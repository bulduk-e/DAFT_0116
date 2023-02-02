# Part 2: analyze data and create a plan for data preparation

# Some client appears multiple times, check that they have same profession throughout the different transaction
# Some client misses information, check if they have other transaction where those missings information appears or not
# Some client have 5 to 10 years old, which is not possible

# make birthyear as in integer, currently a float

# harmonize name in Profession

# possible outlier (TransactionID=16, 4, 3, 2)

# departement is not interesting variable as it is a constant  = 78

# checking if client ID is always with same profession and same 

# there is 3 persons who have weird birthyear (too young to work)

# There doesn't seem to be any duplicate in the transaction : they are some same client but with different amount, on some same amount but with different clients. all good for duplicates 