Procedural Code
```python
# Tool Rental System (Non-OOP Version)

# Inventory of available tools
inventory = {
    "sander": 10,
    "drill": 15,
    "circular saw": 5,
    "jigsaw": 7,
    "reciprocating saw": 3,
    "mitter saw": 4,
    "chain saw": 6
}

# Function to display available tools
def display_stock(inventory):
    for tool, count in inventory.items():
        print(f"We have {count} {tool}(s) available to rent.")

# Function to handle renting a tool
def rent_tool(tool, n, inventory, rental_basis):
    if tool not in inventory or inventory[tool] < n:
        print(f"Sorry, we don't have enough {tool}(s) available.")
        return None
    else:
        inventory[tool] -= n
        print(f"You have rented {n} {tool}(s) on a {rental_basis} basis.")
        return True

# Function to calculate the rental cost (based on rental basis)
def calculate_bill(rental_time, rental_basis, n):
    if rental_basis == "hourly":
        # Calculate the hourly bill
        pass
    elif rental_basis == "daily":
        # Calculate the daily bill
        pass
    elif rental_basis == "weekly":
        # Calculate the weekly bill
        pass
    return bill

# Function to handle returning a tool
def return_tool(tool, rental_time, rental_basis, inventory, n):
    # Replenish stock and calculate the bill
    inventory[tool] += n
    bill = calculate_bill(rental_time, rental_basis, n)
    return bill

# Main function for customer interaction
def main():
    while True:
        print("""
        ====== Tool Rental Shop =======
        1. Display available tools
        2. Rent a tool
        3. Return a tool
        4. Exit
        """)

        choice = input("Enter choice: ")

        if choice == "1":
            display_stock(inventory)
        elif choice == "2":
            # Handle renting a tool
            pass
        elif choice == "3":
            # Handle returning a tool
            pass
        elif choice == "4":
            print("Thank you for using the tool rental system!")
            break
        else:
            print("Invalid choice, please try again.")
```

OOP Implementation code

```python
from datetime import datetime

# Base class for rental operations
class Rental:
    def __init__(self, stock=None):
        if stock is None:
            stock = {}
        self.stock = stock

    def display_stock(self):
        for tool, count in self.stock.items():
            print(f"We have {count} {tool}(s) available to rent.")

# Subclass to handle tool rentals
class ToolRental(Rental):
    RATES = {
        "hourly": {"sander": 3, "drill": 4, "circular saw": 5},
        "daily": {"sander": 15, "drill": 20, "circular saw": 25},
        "weekly": {"sander": 75, "drill": 100, "circular saw": 125}
    }

    def rent_tool(self, tool, n, basis):
        if tool not in self.stock or self.stock[tool] < n:
            print(f"Sorry, we don't have enough {tool}(s) available.")
            return None
        self.stock[tool] -= n
        print(f"You have rented {n} {tool}(s) on {basis} basis.")
        return datetime.now()

    def return_tool(self, tool, rental_time, rental_basis, n):
        self.stock[tool] += n
        # Calculate the bill based on the rental time and basis
        bill = self.calculate_bill(rental_time, rental_basis, n, tool)
        return bill

    def calculate_bill(self, rental_time, rental_basis, n, tool):
        # Placeholder for actual bill calculation logic based on time and rental basis
        return 0

# Class to manage customer information and requests
class Customer:
    def __init__(self):
        self.tool = ""
        self.tools = 0
        self.rental_basis = ""
        self.rental_time = None
        self.bill = 0

    def request_tool(self):
        # Request the tool and quantity from the customer
        pass

    def choose_rental_basis(self):
        # Allow the customer to choose rental basis
        pass

    def return_tool(self):
        # Allow customer to return a tool
        pass

# Main function to manage the tool rental system
def main():
    # Initialize the rental shop and customer
    shop = ToolRental({
        "sander": 10,
        "drill": 15,
        "circular saw": 5
    })
    customer = Customer()

    while True:
        print("""
        ====== Tool Rental Shop =======
        1. Display available tools
        2. Rent a tool
        3. Return a tool
        4. Exit
        """)

        choice = input("Enter choice: ")

        if choice == "1":
            shop.display_stock()
        elif choice == "2":
            # Rent a tool
            pass
        elif choice == "3":
            # Return a tool
            pass
        elif choice == "4":
            print("Thank you for using the tool rental system!")
            break
        else:
            print("Invalid choice, please try again.")
```

## Key Differences and Benefits of OOP over Procedural Code:
- **Encapsulation**: In the OOP version, tools and rental operations are encapsulated in classes. This means that changes to the tool rental process or inventory can be made within the class without affecting the rest of the code.
- **Modularity and Reusability**: Classes like ToolRental and Customer can be reused across different parts of the system or even in other systems, without duplicating code. For example, you can easily extend ToolRental to add new features, such as discounted rates or special rental plans.
- **Easier Maintenance**: In the OOP approach, each functionality (e.g., tool rental, tool return, displaying stock) is clearly organized into its respective class and method. This makes it easier to manage and extend in the future.
