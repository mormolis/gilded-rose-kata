# Gilded Rose Kata
Story and specs can be found [here](https://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/)

## Approach
I started by analysing the specification and made notes on every item's particular instructions of handling.

I then started writing tests on each item covering as many cases as I could thought of covering edge cases for each item.

When I made sure that I had covered every possible scenario and the tests were passing I tried to take a look at the code and understand the logic of the programmer. 

I decided to rewrite the code from scratch having the guidance of the tests.

When I finished refactoring the existing logic, I wrote tests for the new supplier. With the guidance of the tests I used the common_item's helper method to create an appropriate one for the conjured items since they were sharing a lot of common characteristics .

Then extracted helper methods to make the code more readable (ex. has_expired?) 

****
## Code Structure 

Since the goblin in the corner was looking at me in a peculiar way that only goblins can do, I decided to follow the instructions and not to touch its class Item.

Therefore :
* update_quality() has the responsibility of checking the type of the item and delegating to an appropriate method according to the item

* Each item has its own private method for updating quality 

* There are several private predicate methods that make the code more readable 
***
## Notes
Since *Sulfuras, Hand of Ragnaros* is a legendary item and its quality remains the same as the time passes by I didn't create a method that handles it. If the goblin was not present I might had added a helper method to Item just to make sure that the quality is for this item is always 80.
