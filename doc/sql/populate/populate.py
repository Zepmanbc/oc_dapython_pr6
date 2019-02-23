#! /usr/bin/env python3

from random import randint
import random
import time

def strTimeProp(start, end, format, prop):
    """Get a time at a proportion of a range of two formatted times.

    start and end should be strings specifying times formated in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))

def randomDate(start, end, prop):
    return strTimeProp(start, end, '%Y-%m-%d %H:%M:%S', prop)

def boutique():
    return randint(1,4)

def recette():
    return randint(1,3)

def nbr_recette():
    return randint(1,5)

def paiement():
    payment_type = randint(1,4)
    if payment_type == 4:
        return (payment_type, True)
    return (payment_type, False)

def randtime():
    return randomDate("2019-02-20 1:30:00", "2019-02-20 4:50:00", random.random())

# print("DECLARE NewCommande int;")
for client in range(1, 11):

    insert = "INSERT INTO oc_dapython_pr6.commande (client_id, boutique_id, paiement_type_id, date, paiement) VALUES "
    (paiement_type, paid) = paiement()
    var = "('{}', '{}', '{}', '{}', {});".format(client, boutique(), paiement_type, randtime(), paid )
    print(insert+var)
    
    print("SET @NewCommande = (SELECT MAX(id) FROM oc_dapython_pr6.commande);")
    for pizz in range(nbr_recette()):
        insert = "INSERT INTO `oc_dapython_pr6`.`commande_composition` (`commande_id`, `recette_id`) VALUES "
        var = "(@NewCommande, '{}');".format(recette())
        print(insert+var)







# for boutique in [1,2,3]:
#     for ingredient in range(16):
#         print("insert into stock \
#             (ingredient_id, \
#             boutique_id, \
#             quantite) values \
#             ({}, {}, {});".format(ingredient+1, boutique, randint(0,5000)))
