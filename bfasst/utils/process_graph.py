"""Compute metrics on a single graph in a dataset."""

import argparse
from collections import defaultdict, deque
import logging
import os
import json

logger = logging.getLogger(__name__)


def main():
    """Load the graph, convert to adj_list, and compute metrics."""
    # ArgParse
    parser = argparse.ArgumentParser(description="Compute metrics on a graph.")
    parser.add_argument("graph", help="The graph to compute metrics on.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable debug logging.")
    parser.add_argument("-o", help="The name of the output file to create")

    parser.add_argument("--order", action="store_true", help="Compute the order of the graph.")
    parser.add_argument("--size", action="store_true", help="Compute the size of the graph.")
    parser.add_argument(
        "--degree", action="store_true", help="Compute the average degree of the graph."
    )
    parser.add_argument(
        "--diameter", action="store_true", help="Compute the average diameter of the graph."
    )
    parser.add_argument("--kcore", action="store_true", help="Compute the k-core of the graph.")
    parser.add_argument(
        "--global_clustering_coeff",
        action="store_true",
        help="Compute the global clustering coefficient of the graph.",
    )
    parser.add_argument(
        "--local_clustering_coeff",
        action="store_true",
        help="Compute the local clustering coefficient of the graph.",
    )
    parser.add_argument("--all", action="store_true", help="Compute all metrics.", default=True)

    args = parser.parse_args()

    # Logging (for debug, don't use in parallel)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
    )

    component_nodes, component_edges = load_graph(args.graph)

    adj_lists = convert_to_adj_list(component_nodes, component_edges)

    # Compute metrics for each component
    metrics_per_ip = compute_metrics_per_ip(adj_lists, args)

    # write metrics to a file
    output = args.o if args.o else "metrics.log"
    with open(os.path.abspath(output), "w") as f:
        f.write(json.dumps(metrics_per_ip))


def load_graph(graph):
    """Load a graph from a file."""
    graph_path = os.path.abspath(graph)

    component_nodes = defaultdict(list)  # {ip_inst: [node1, node2, ...]}
    component_edges = defaultdict(list)  # {ip_inst: [(node1, node2), ...]}
    section = None  # track the section: nodes or edges

    with open(graph_path, "r") as f:
        for line in f:
            line = line.strip()

            # Detect the beginning of a section
            if line.startswith("(("):
                if section is None:
                    section = "nodes"
                else:
                    section = "edges"
                line = line[1:].strip()  # Remove the opening '('

            # Detect the end of a section
            if line == ")":
                continue

            if not line:
                continue  # Skip empty lines

            if section == "nodes":
                parts = line.replace('"', "").split()
                node_id, label = parts[0], parts[2]
                node_id = node_id.replace("(", "")
                if "ip" not in label:
                    label = "fabric"
                component_nodes[label].append(node_id)

            elif section == "edges":
                node1, node2 = line.replace('"', "").replace("(", "").replace(")", "").split()
                # get the label for both nodes
                node1_label = find_label(node1, component_nodes)
                node2_label = find_label(node2, component_nodes)
                if node1_label == node2_label:
                    component_edges[node1_label].append((node1, node2))

    return component_nodes, component_edges


def find_label(node, component_nodes):
    """Find the label for a node."""
    for label, nodes in component_nodes.items():
        if node in nodes:
            return label
    return None


def convert_to_adj_list(component_nodes, component_edges):
    """Convert the graph to adjacency lists."""
    adj_lists = {}
    for label, nodes in component_nodes.items():
        adj_lists[label] = {}
        for node in nodes:
            adj_lists[label][node] = []

    for label, edges in component_edges.items():
        for node1, node2 in edges:
            adj_lists[label][node1].append(node2)
            adj_lists[label][node2].append(node1)

    return adj_lists


def compute_metrics_per_ip(adj_lists, args):
    metrics_per_ip = {}
    for label, adj_list in adj_lists.items():

        # set up default entries
        ip = get_ip_name_from_label(label)
        if ip not in metrics_per_ip:
            metrics_per_ip[ip] = {
                "order": [],
                "size": [],
                "degree": [],
                "diameter": [],
                "kcore": [],
                "global_clustering_coeff": [],
                "local_clustering_coeff": [],
            }

        # Order
        if args.all or args.order:
            metrics_per_ip[ip]["order"].append(len(adj_list))

        # Size
        if args.all or args.size:
            edge_count = compute_size(adj_list)
            metrics_per_ip[ip]["size"].append(edge_count)

        # Degree
        if args.all or args.degree:
            avg_desgree = compute_average_degree(adj_list)
            metrics_per_ip[ip]["degree"].append(avg_desgree)

        # Diameter
        if args.all or args.diameter:
            avg_diameter = compute_average_diameter(adj_list)
            metrics_per_ip[ip]["diameter"].append(avg_diameter)

        # K-core
        if args.all or args.kcore:
            max_k, _ = compute_k_core(adj_list)
            metrics_per_ip[ip]["kcore"].append(max_k)

        # Global Clustering Coefficient
        if args.all or args.global_clustering_coeff:
            global_clustering = compute_global_clustering(adj_list)
            metrics_per_ip[ip]["global_clustering_coeff"].append(global_clustering)

        # Local Clustering Coefficient
        if args.all or args.local_clustering_coeff:
            local_clustering = compute_local_clustering(adj_list)
            metrics_per_ip[ip]["local_clustering_coeff"].append(local_clustering)

        # Debug (verbose flag only)
        logger.debug(f"IP: {ip}")
        logger.debug(f"Component: {label}")
        logger.debug(f"Nodes: {len(adj_list)}")
        logger.debug(f"Edges: {edge_count}")
        logger.debug("")

    return metrics_per_ip


def compute_size(adj_list):
    edge_count = 0
    for node in adj_list:
        for neighbor in adj_list[node]:
            edge_count += 1
    return edge_count // 2


def compute_average_diameter(adj_list):
    uf = UnionFind()

    for u in adj_list:
        for v in adj_list[u]:
            uf.union(u, v)

    components = {}
    for node in adj_list:
        root = uf.find(node)
        if root not in components:
            components[root] = set()
        components[root].add(node)

    diameters = []

    for component in components.values():
        node = next(iter(component))
        u, _ = bfs_farthest(adj_list, node)
        _, diameter = bfs_farthest(adj_list, u)
        diameters.append(diameter)

    return sum(diameters) / len(diameters) if diameters else 0


def compute_average_degree(adj_list):
    degrees = []
    for node in adj_list:
        degrees.append(len(adj_list[node]))
    return sum(degrees) / len(degrees) if degrees else 0


class UnionFind:
    def __init__(self):
        self.parent = {}
        self.rank = {}

    def add(self, u):
        if u not in self.parent:
            self.parent[u] = u
            self.rank[u] = 0

    def find(self, u):
        # Ensure u is in the union find
        self.add(u)

        # Path compression
        if self.parent[u] != u:
            self.parent[u] = self.find(self.parent[u])
        return self.parent[u]

    def union(self, u, v):
        self.add(u)
        self.add(v)
        pu, pv = self.find(u), self.find(v)

        if pv != pu:
            if self.rank[pu] > self.rank[pv]:
                self.parent[pv] = pu
            elif self.rank[pv] > self.rank[pu]:
                self.parent[pu] = pv
            else:
                self.parent[pv] = pu
                self.rank[pu] += 1


def bfs_farthest(adj_list, start_node):
    queue = [(start_node, 0)]
    visited = {start_node}
    farthest_node = start_node
    max_distance = 0

    while queue:
        node, distance = queue.pop(0)
        if distance > max_distance:
            max_distance = distance
            farthest_node = node

        for neighbor in adj_list[node]:
            if neighbor not in visited:
                queue.append((neighbor, distance + 1))
                visited.add(neighbor)

    return farthest_node, max_distance


def compute_k_core(adj_list):
    degree = {node: len(neighbors) for node, neighbors in adj_list.items()}
    max_k = 0
    k_core_subgraph = {}

    k = 1
    while True:
        queue = deque(node for node, d in degree.items() if d <= k)

        while queue:
            node = queue.popleft()
            for neighbor in adj_list[node]:
                if degree[neighbor] >= k:
                    degree[neighbor] -= 1
                    if degree[neighbor] < k:
                        queue.append(neighbor)
            degree[node] = 0

        k_core = {
            node: {neighbor for neighbor in neighbors if degree[neighbor] >= k}
            for node, neighbors in adj_list.items()
            if degree[node] >= k
        }

        if k_core:
            k_core_subgraph = k_core
            max_k = k
        else:
            break

        k += 1

    return max_k, k_core_subgraph


def compute_global_clustering(adj_list):
    closed_triplets = 0
    total_triplets = 0
    visited_pairs = set()

    for node in adj_list:
        neighbors = set(adj_list[node])
        degree = len(neighbors)

        total_triplets += degree * (degree - 1) // 2

        for neighbor in neighbors:
            if (node, neighbor) in visited_pairs or (neighbor, node) in visited_pairs:
                continue

            common_neighbors = neighbors.intersection(set(adj_list[neighbor]))
            closed_triplets += len(common_neighbors)
            visited_pairs.add((node, neighbor))

    return (3 * closed_triplets) / total_triplets if total_triplets else 0


def compute_local_clustering(adj_list):
    local_clustering_coefficients = []

    for node in adj_list:
        neighbors = set(adj_list[node])
        degree = len(neighbors)

        if degree < 2:
            local_clustering_coefficients.append(0)
            continue

        closed_triplets = 0

        for neighbor in neighbors:
            common_neighbors = neighbors.intersection(set(adj_list[neighbor]))
            closed_triplets += len(common_neighbors)

        local_clustering_coefficients.append(
            (closed_triplets) / (degree * (degree - 1)) if degree > 1 else 0
        )

    return (
        sum(local_clustering_coefficients) / len(local_clustering_coefficients)
        if local_clustering_coefficients
        else 0
    )


def get_ip_name_from_label(label):
    ip_name = ("_").join(label.split("_")[2:])
    return ip_name if ip_name else label


if __name__ == "__main__":
    main()
