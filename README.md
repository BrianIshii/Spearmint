API changes:

Map Kit instead of google places for nearby locations. This change is because it is much easier to use Map Kit's location query and it's free. 
To see it working try adding a transaction and it will print out nearby locations. I will add the locations to auto fill sections for the vendor text field.

Firebase ML instead of Tesseract because after research, I found out that Tesseract is not that effective. Firebase ML works much better, and if I don't use cloud it is "free"
To see in action, add an image with text to a transaction. There will be output of the text. 

For product search, I am just using good search. Google does not have a product search API (they have a paid advanced search but I am essentially doing the same thing). The amazon product search I have to pay for, and I tried using Walmart's API, but I couldn't set up an account (I never got an email verification aparently it is still in beta and other people were having the same issue). I also tried target, but I would have to pay for theirs too/ I couldn't find a way to pay for it. 
To see this in action, tap on any of the cells and it will show the google search query for paper.
