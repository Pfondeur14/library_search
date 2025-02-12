<h1>Library Book and Author Search</h1>

<h3>Overview</h3>

This R script allows a librarian to search for books based on various attributes (such as title, genre, or publication year)
stored in a CSV file, or search for books written by authors from a specific hometown, based on a second CSV file containing 
author data. The librarian can choose the search criteria from a menu and enter relevant search terms. The results are displayed
as a subset of the books data.

The script utilizes two CSV files:
<ul>
  <li>books.csv - Contains information about books (e.g., title, author, genre, etc.).</li>
  <li>authors.csv - Contains information about authors, including their hometown.</li>
</ul>


<h3>Requirements</h3>
No requirements except for a Basic R environment for running scripts.

<h3>Script Breakdown</h3>

1. Reading the Data

This part reads the books.csv and authors.csv files into two data frames (books and authors).
<pre>
  <code>
    books <- read.csv("books.csv")
    authors <- read.csv("authors.csv")
  </code>
</pre>


2. Creating the Search Options Menu

The script extracts the column names from both the books and authors data frames to create search options.
<pre>
  <code>
    search_options <- colnames(books)
    hometown_option <- colnames(authors)
  </code>
</pre>

The options_menu is a list of menu items that combines the columns of the books dataset and adds an option to search by the author's hometown.
<pre>
  <code>
    options_menu <- paste0(1:length(search_options), ". ", search_options)
    options_menu <- append(options_menu, paste0("6. ", hometown_option[2]), after = length(options_menu))
  </code>
</pre>


3. Asking the Librarian for Search Criteria
   
The script displays the menu to the librarian, who is prompted to choose the search criteria by entering the corresponding number.
<pre>
  <code>
    cat(options_menu, sep = "\n")
    search_by <- as.integer(readline("Select menu option to search by: "))
  </code>
</pre>


4. Searching the Books Data

<h4>Search by Book Attributes (Columns 1-5)</h4>

If the librarian chooses an option between 1 and 5 (book attributes), the script asks for a search term and searches
the selected column in the books dataset for matching entries using the grepl() function. If matches are found, the
subset of books that match the query is displayed; otherwise, it prints "Not Found." 
<pre>
  <code>
    if (search_by <= 5){
      selected_column <- search_options[search_by]
      query = readline("Enter search term: ")
        
      if (any(grepl(query, books[[selected_column]]))) {
        print(subset(books, grepl(query, books[[selected_column]])))
      } else {
        cat("Not Found")
        }
    }
  </code>
</pre>

<h4>Search by Author's Hometown (Option 6 and above)</h4>

If the librarian chooses an option greater than 5, the script allows searching by the author's hometown. It checks the 
second column of the authors.csv file for matching hometowns. Once a matching hometown is found, the script uses the 
author's name to search for books written by those authors in the books.csv file.

<pre>
  <code>
    } else if (search_by > 5){
      selected_column <- hometown_option[2]
      query = readline("Enter town name: ")
  
      if (query %in% authors[["hometown"]]){
        author_search <- subset(authors, authors[[selected_column]] == query)
    }
  
      query <- author_search[,1]
      query <- paste(query, collapse = "|")
      
      if (any(grepl(query, books[,2]))) {
        print(subset(books, grepl(query, books[,2])))
      } else {
        cat("Not Found")
      }
    }
  </code>
</pre>


5. Displaying Results
   
If a match is found, a subset of books (where the author's name or other relevant details match the search query) is displayed.
If no matches are found, the script prints "Not Found."

<h3>Example Usage</h3>
<ul>
  <li>Ensure you have the books.csv and authors.csv files in your working directory.</li>
  <li>Run the script to display a list of search options.</li>
  <li>Select the search option based on the desired search criteria (e.g., search by book title, genre, or author's hometown).</li>
  <li>Enter the corresponding search term (e.g., book title, author's hometown, etc.).</li>
  <li>The script will display the search results or a "Not Found" message if no matches are found.</li>
</ul>


<h3>Notes</h3>

<ul>
  <li>The books.csv file should contain columns with book attributes like title, genre, author, and other relevant details.</li>
  <li>The authors.csv file should contain author information, with a column for the hometown.</li>
  <li>The script assumes the second column of authors.csv contains the hometown information.</li>
</ul>


<h3>Customization</h3>

To adapt the script for your specific use case, modify the column names in the books.csv and authors.csv files.
You can add more search criteria by extending the options_menu and adjusting the conditional logic for handling different search cases
