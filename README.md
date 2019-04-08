
<!-- README.md is generated from README.Rmd. Please edit that file -->
<link href="inst/reports/default/webex.css" rel="stylesheet" />

webex
=====

The goal of webex is to enable instructors to easily create web documents that students can use in self-assessment.

Installation
------------

You can install the released version of webex from [GitHub](https://github.com/PsyTeachR/webex) with:

``` r
devtools::install_packages_github("PsyTeachR/webex")
```

Example
-------

This is a Web Exercise template created by the [psychology teaching team at the University of Glasgow](http://www.psy.gla.ac.uk), based on ideas by [Software Carpentry](https://software-carpentry.org/lessons/). This template enables instructors to easily create web documents that students can use in self-assessment.

The webex package provides a number of functions that you use in [inline R code](https://github.com/rstudio/cheatsheets/raw/master/rmarkdown-2.0.pdf) to create HTML widgets (text boxes, pull down menus, buttons that reveal hidden content). Examples are provided in this document. Knit this file to HTML to see how it works.

**NOTE: To use the widgets in the compiled HTML file, you need to have a JavaScript-enabled browser. The widgets don't work in the built-in RStudio browser. In the built-in browser, click the "Open in Browser" button to open the file in your operating system's browser.**

Fill-In-The-Blanks (`fitb()`)
-----------------------------

Create fill-in-the-blank questions using `fitb()`, providing the answer as the first argument.

-   2 + 2 is <input class='solveme nospaces' size='1' data-answer='["4"]'/>

You can also create these questions dynamically, using variables from your R session.

-   The square root of 64 is: <input class='solveme nospaces' size='1' data-answer='["8"]'/>

The blanks are case-sensitive; if you don't care about case, use the argument `ignore_case = TRUE`.

-   What is the letter after D? <input class='solveme nospaces ignorecase' size='1' data-answer='["E"]'/>

If you want to ignore differences in whitespace use, use the argument `ignore_ws = TRUE` and include spaces in your answer anywhere they could be acceptable..

-   How do you load the tidyverse package? <input class='solveme nospaces ignorecase' size='20' data-answer='["library( tidyverse )"]'/>

You can set more than one possible correct answer by setting the answers as a vector.

-   Type a vowel: <input class='solveme nospaces ignorecase' size='1' data-answer='["A","E","I","O","U"]'/>

Multiple Choice (`mcq()`)
-------------------------

-   "Never gonna give you up, never gonna: <select class='solveme' data-answer='["let you down"]'> <option></option> <option>let you go</option> <option>turn you down</option> <option>run away</option> <option>let you down</option></select>"
-   "I <select class='solveme' data-answer='["bless the rains"]'> <option></option> <option>bless the rains</option> <option>guess it rains</option> <option>sense the rain</option></select> down in Africa" -Toto

True or False (`torf()`)
------------------------

-   You can permute values in a vector using `sample()`. <select class='solveme' data-answer='["TRUE"]'> <option></option> <option>TRUE</option> <option>FALSE</option></select>

Hidden solutions and hints (`hide()` and `unhide()`)
----------------------------------------------------

-   Recreate the scatterplot below, using the built-in `cars` dataset.

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

<button>
I need a hint
</button>
`?plot`

<button>
Solution
</button>
``` r
with(cars, plot(speed, dist))
```

*Don't forget to `unhide()` after the solution!*

<script>

/* update total correct if #total_correct exists */
update_total_correct = function() {
  if (t = document.getElementById("total_correct")) {
    t.innerHTML =
      document.getElementsByClassName("correct").length + " of " +
      document.getElementsByClassName("solveme").length + " correct";
  }
}

/* solution button toggling function */
b_func = function() {
  var cl = this.parentElement.classList;
  if (cl.contains('open')) {
    cl.remove("open");
  } else {
    cl.add("open");
  }
}

/* function for checking solveme answers */
solveme_func = function(e) {
  var real_answers = JSON.parse(this.dataset.answer);
  var my_answer = this.value;
  var cl = this.classList;
  if (cl.contains("ignorecase")) {
    my_answer = my_answer.toLowerCase();
  }
  if (cl.contains("nospaces")) {
    my_answer = my_answer.replace(/ /g, "");
  }
  
  if (my_answer !== "" & real_answers.includes(my_answer)) {
    cl.add("correct");
  } else {
    cl.remove("correct");
  }

  // match numeric answers within a specified tolerance
  if(this.dataset.tol){
    var tol = JSON.parse(this.dataset.tol);  
    var matches = real_answers.map(x => Math.abs(x - my_answer) < tol)
    if (matches.reduce((a, b) => a + b, 0) > 0) {
      cl.add("correct");
    } else {
      cl.remove("correct");
    }  
  }

  // added regex bit
  if (cl.contains("regex")){
    answer_regex = RegExp(real_answers.join("|"))
    if (answer_regex.test(my_answer)) {
      cl.add("correct");
    }  
  }
  
  update_total_correct();
}

window.onload = function() {
  /* set up solution buttons */
  var buttons = document.getElementsByTagName("button");

  for (var i = 0; i < buttons.length; i++) {
    if (buttons[i].parentElement.classList.contains('solution')) {
      buttons[i].onclick = b_func;
    }
  }
  
  /* set up solveme inputs */
  var solveme = document.getElementsByClassName("solveme");

  for (var i = 0; i < solveme.length; i++) {
    /* make sure input boxes don't auto-anything */
    solveme[i].setAttribute("autocomplete","off");
    solveme[i].setAttribute("autocorrect", "off");
    solveme[i].setAttribute("autocapitalize", "off"); 
    solveme[i].setAttribute("spellcheck", "false");
    solveme[i].value = "";
    
    /* adjust answer for ignorecase or nospaces */
    var cl = solveme[i].classList;
    var real_answer = solveme[i].dataset.answer;
    if (cl.contains("ignorecase")) {
      real_answer = real_answer.toLowerCase();
    }
    if (cl.contains("nospaces")) {
      real_answer = real_answer.replace(/ /g, "");
    }
    solveme[i].dataset.answer = real_answer;
    
    /* attach checking function */
    solveme[i].onkeyup = solveme_func;
    solveme[i].onchange = solveme_func;
  }
  
  update_total_correct();
}

</script>
