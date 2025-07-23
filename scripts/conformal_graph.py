import re
import networkx as nx
import matplotlib.pyplot as plt
from pathlib import Path

# Read input
conformal_report = Path("conformal_report.txt").read_text().splitlines()

edges = []
current_g = current_r = None

for line in conformal_report:
    g_match = re.match(r"\s*\(G\)\s+\+\s+\d+\s+\w+\s+(\S+)", line)
    r_match = re.match(r"\s*\(R\)\s+\+\s+\d+\s+\w+\s+(\S+)", line)

    if g_match:
        current_g = g_match.group(1)
    elif r_match and current_g:
        current_r = r_match.group(1)
        edges.append((current_g, current_r))
        current_g = current_r = None

# Create graph
G = nx.DiGraph()
G.add_edges_from(edges)

# Save DOT file
dot_output_path = Path("conformal_graph.dot")
nx.drawing.nx_pydot.write_dot(G, dot_output_path)

# Optional: visualize and save PNG
plt.figure(figsize=(12, 8))
pos = nx.spring_layout(G, k=0.5)
nx.draw(
    G, pos,
    with_labels=True,
    node_size=2000,
    node_color="lightblue",
    font_size=6,
    edge_color="gray",
    arrows=True,
)
plt.title("Conformal Non-equivalence Dependency Graph")
plt.tight_layout()
plt.savefig("conformal_graph.png")

