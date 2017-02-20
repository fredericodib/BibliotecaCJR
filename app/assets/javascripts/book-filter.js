function booksFilter() {
  // Declare variables 
  var input, filter, box, name, i;
  input = document.getElementById("book-search");
  filter = input.value.toUpperCase();
  box = document.getElementsByClassName("box-books");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < box.length; i++) {
    name = $(box[i]).find("[data-book='']");
    if (name) {
      if ($(name).html().toUpperCase().indexOf(filter) > -1) {
        box[i].style.display = "";
      } else {
        box[i].style.display = "none";
      }
    } 
  }
}


function clearBookList() {
  $(".book_list").remove();
};


$(document).on('turbolinks:load', function() {
  $(document).ready(function() {
    $("#sellectCategory").change(function() {
      clearBookList();
      var value = $(this).val() != "0" ? "/" + $(this).val() : "";
      var url = "/books/categories" + value + "/filter.js";
      console.log(url);
      $.get(url);
    });
  });
});