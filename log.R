# Read the csv files
books <- read.csv("books.csv")
authors <- read.csv("authors.csv")

# Use col names to create variables for search options
search_options <- colnames(books)
hometown_option <-colnames(authors)

# Create options menu by pasting and appending using the column names variables
options_menu <- paste0(1:length(search_options), ". ", search_options)
options_menu <- append(options_menu, paste0("6. ", hometown_option[2]), after = length(options_menu))

# Ask Librarian to choose "Search by" from a menu
cat(options_menu, sep = "\n")
search_by <- as.integer(readline("Select menu option to search by: "))
# Use conditional statement to determine if menu option selected is less or equal to 5, to search the books csv file
if (search_by <= 5){
  # Use the integer selected from menu to index into search options and assign column name to a variable
  selected_column <- search_options[search_by]
  # Ask Librarian for a search term
  query = readline("Enter search term: ")
  # any() makes sure the conditional accepts more than one value but returns only one. grepl() Will match substrings in the selected vector
  if (any(grepl(query, books[[selected_column]]))) {
    # Print the subset where the query matches the selected column in the the books csv file
    print(subset(books, grepl(query, books[[selected_column]])))
    # If there is no match print "Not Found"
  } else if (any(!query %in% books[[selected_column]])) {
    cat("Not Found")
  }
  # Use conditional statement to determine if menu option selected is greater than 5, to search the authors csv file by hometown first
} else if (search_by > 5){
  # Use the column names variable and extract the hometown column name
  selected_column <- hometown_option[2]
  # Ask Librarian for a town name
  query = readline("Enter town name: ")
  # %in% returns true od false whether the town name is in the hometown column
  if (query %in% authors[["hometown"]]){
    # Create a subset with the rows where the search query matches the hometown column
    author_search <- subset(authors, authors[[selected_column]] == query)
  }
  # Pull the values from the subset author column
  query <- author_search[,1]
  # Change vector into a pattern
  query<-paste(query, collapse = "|")
  # any() will return a single value. grepl() Will match substrings in the selected vector
  if(any(grepl(query, books[,2]))) {
    # Print the subset where the query matches the selected column in the the books csv file
    print(subset(books, grepl(query, books[,2])))
    # If there is no match print "Not Found"
  } else if (!query %in% books[,2]){
    cat("Not Found")
  }
}