#!/usr/bin/env python

'''Quine-McCluskey two-level logic minimization method.

Copyright 2008, Robert Dick <dickrp@eecs.umich.edu> with improvements
from Pat Maupin <pmaupin@gmail.com>.

Routines to compute the optimal sum of products implementation from sets of
don't-care terms, minterms, and maxterms.

Command-line usage example:
  qm_f.py -o1,2,5 -d0,7

Library usage example:
  import qm_f
  print qm_f.qm_f(ones=[1, 2, 5], dc_a=[0, 7])

Please see the license file for legal information.'''


__version__ = '0.2'
__author__ = 'Robert Dick'
__author_email__ = 'dickrp@eecs.umich.edu'


import math


def qm_f(ones=None, zeros=None, dc_a=None):
    '''Compute minimal two-level sum-of-products form.
	Arguments are:
		ones: iterable of integer minterms
		zeros: iterable of integer maxterms
		dc_a: iterable of integers specifying don't-care terms

	For proper operation, either (or both) the 'ones' and 'zeros'
	parameters must be specified.  If one of these parameters is not
	specified, it will be computed from the combination of the other
	parameter and the optional 'dc_a' parameter.

	An assertion error will be raised if any terms are specified
	in more than one argument, or if all three arguments are given
	and not all terms are specified.'''

    if ones is None:
        ones = []

    if zeros is None:
        zeros = []

    if dc_a is None:
        dc_a = []

    first_max = max(ones or zeros or dc_a)
    second_max = max(zeros or dc_a or ones)
    third_max = max(dc_a or ones or zeros)

    elts = max(first_max, second_max, third_max) + 1
    numvars = int(math.ceil(math.log(elts, 2)))
    elts = 1 << numvars
    all_v = set(b2s(i, numvars) for i in range(elts))
    ones = set(b2s(i, numvars) for i in ones)
    zeros = set(b2s(i, numvars) for i in zeros)
    dc_a = set(b2s(i, numvars) for i in dc_a)
    ones = ones or (all_v - zeros - dc_a)
    zeros = zeros or (all_v - ones - dc_a)
    dc_a = dc_a or (all_v - ones - zeros)
    assert len(dc_a) + len(zeros) + len(ones) == len(dc_a | zeros | ones) == elts
    primes = compute_primes(ones | dc_a, numvars)
    # return unate_cover(primes, ones)
    return primes


def unate_cover(primes, ones):
    '''Return the minimal cardinality subset of primes covering all ones.

	Exhaustive for now.  Feel free to replace this with an efficient unate
	covering problem solver.'''

    primes = list(primes)
    cs_v = min((bitcount(b2s(cubesel, len(primes))), cubesel)
		for cubesel in range(1 << len(primes))
		if is_full_cover(active_primes(cubesel, primes), ones))[1]
    return active_primes(cs_v, primes)


def active_primes(cubesel, primes):
    '''Return the primes selected by the cube selection integer.'''
    return [prime for used, prime in
		zip(map(int, b2s(cubesel, len(primes))), primes) if used]


def is_full_cover(all_primes, ones):
    '''Return a bool: Does the set of primes cover all minterms?'''
    return min([max([is_cover(p, o) for p in all_primes] + [False])
		for o in ones] + [True])


def is_cover(prime, one):
    '''Return a bool: Does the prime cover the minterm?'''
    return min([p in ('X', o) for p, o in zip(prime, one)] + [True])


def compute_primes(cubes, vars_a):
    '''Compute primes for the given set of cubes and variable count.'''
    sigma = [set(i for i in cubes if bitcount(i) == v)
		for v in range(vars_a + 1)]
    primes = set()
    while sigma:
        nsigma = []
        redundant = set()
        for c1_i, c2_i in zip(sigma[:-1], sigma[1:]):
            nc_v = set()
            for a_i in c1_i:
                for b_i in c2_i:
                    m_v = merge(a_i, b_i)
                    if m_v:
                        nc_v.add(m_v)
                        redundant |= set([a_i, b_i])
            nsigma.append(nc_v)
        primes |= set(c for cubes in sigma for c in cubes) - redundant
        sigma = nsigma
    return primes


def bitcount(s_a):
    '''Return the sum of on bits in s.'''
    return sum(b == '1' for b in s_a)


def b2s(i, vars_a):
    '''Convert from an integer to a binary string.'''
    s_v = ''
    for _ in range(vars_a):
        s_v = ['0', '1'][i & 1] + s_v
        i >>= 1
    return s_v


def merge(i, j):
    '''Return cube merge.  'X' is don't-care.  'None' if merge impossible.'''
    s_v = ''
    dif_cnt = 0
    for a_i, b_i in zip(i, j):
        if (a_i == 'X' or b_i == 'X') and a_i != b_i:
            return None
        if a_i != b_i:
            dif_cnt += 1
            s_v += 'X'
        else:
            s_v += a_i
        if dif_cnt > 1:
            return None
    return s_v


if __name__ == '__main__':

    def main():
        """Ignored for this script"""

    main()
