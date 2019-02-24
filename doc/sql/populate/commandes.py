#! /usr/bin/env python3
"""
Create 10 commandes
with 1 to 5 pizzas
for each 10 first customers

How to use:
    python3 commandes.py > commandes.sql

"""

from random import randint
import random
import time

def str_time_prop(start, end, format_, prop):
    """Get a time at a proportion of a range of two formatted times.

    start and end should be strings specifying times formated in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, format_))
    etime = time.mktime(time.strptime(end, format_))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format_, time.localtime(ptime))

def random_date(start, end, prop):
    """Generate randon date between start ans end."""
    return str_time_prop(start, end, '%Y-%m-%d %H:%M:%S', prop)

def randtime():
    """Return random date."""
    return random_date("2019-02-20 1:30:00", "2019-02-20 4:50:00", random.random())

def boutique():
    """Return random store between 1 and 4."""
    return randint(1, 4)

def recette():
    """Return random recette betweem 1 and 3."""
    return randint(1, 3)

def nbr_recette():
    """Return a random number of recette between 1 and 5."""
    return randint(1, 5)

def paiement():
    """Return True if paiment is online, if other, return random True or False."""
    payment_type = randint(1, 4)
    if payment_type == 4:
        return (payment_type, True)
    return (payment_type, False)

for client in range(1, 11):
    insert = "INSERT INTO oc_dapython_pr6.commande (client_id, boutique_id, paiement_type_id, date, paiement) VALUES "
    (paiement_type, paid) = paiement()
    var = "('{}', '{}', '{}', '{}', {});".format(client, boutique(), paiement_type, randtime(), paid)
    print(insert+var)

    print("SET @NewCommande = (SELECT MAX(id) FROM oc_dapython_pr6.commande);")
    for pizz in range(nbr_recette()):
        insert = "INSERT INTO oc_dapython_pr6.commande_composition (commande_id, recette_id) VALUES "
        var = "(@NewCommande, '{}');".format(recette())
        print(insert+var)
