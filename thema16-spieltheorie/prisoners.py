#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division
import random

DEFECT    = 0
COOPERATE = 1

def strategyAlwaysDefect(previousOpponentMove, numOpponentDefections):
    return DEFECT

def strategyAlwaysCooperate(previousOpponentMove, numOpponentDefections):
    return COOPERATE

def strategyTitForTat(previousOpponentMove, numOpponentDefections):
    if previousOpponentMove is None:
        return COOPERATE
    else:
        if previousOpponentMove == COOPERATE:
            return COOPERATE
        else:
            return DEFECT

def strategyTitForTat0(previousOpponentMove, numOpponentDefections):
    if previousOpponentMove is None:
        return DEFECT
    else:
        if previousOpponentMove == COOPERATE:
            return COOPERATE
        else:
            return DEFECT

def strategyRandom(previousOpponentMove, numOpponentDefections):
    if random.random() >= 0.5:
        return COOPERATE
    else:
        return DEFECT

def tournament(player1, player2, numTurns):
    score1 = 0
    score2 = 0

    numberDefections1 = 0
    numberDefections2 = 0

    previousTurn1 = None
    previousTurn2 = None

    for i in range(numTurns):
        decision1 = player1(previousTurn2, numberDefections2)
        decision2 = player2(previousTurn1, numberDefections1)

        previousTurn1 = decision1
        previousTurn2 = decision2

        if decision1 == COOPERATE and decision2 == COOPERATE:
            score1 = score1 + 3
            score2 = score2 + 3
        elif decision1 == COOPERATE and decision2 == DEFECT:
            score1 = score1 + 0
            score2 = score2 + 5
            numberDefections2 = numberDefections2 + 1
        elif decision1 == DEFECT and decision2 == COOPERATE:
            score1 = score1 + 5
            score2 = score2 + 0
            numberDefections1 = numberDefections1 + 1
        else:
            score1 = score1 + 1
            score2 = score2 + 1
            numberDefections1 = numberDefections1 + 1
            numberDefections2 = numberDefections2 + 1

    return (score1, score2)

strategies = dict((k, v) for k, v in locals().items() if k.startswith("strategy"))

totals = dict((k, 0) for k in strategies)

for s1 in strategies:
    for s2 in strategies:
        score1, score2 = tournament(strategies[s1], strategies[s2], 100)
        print("%25s gegen %25s: (%3d, %3d)" % (s1, s2, score1, score2))
        totals[s1] = totals[s1] + score1
        totals[s2] = totals[s2] + score2

print("")

for w in sorted(totals, key=totals.get):
  print("* %25s: %4d" % (w, totals[w]))
