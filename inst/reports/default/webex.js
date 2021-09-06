<script>

/* update total correct if #webex-total_correct exists */
update_total_correct = function() {
  if (t = document.getElementById("webex-total_correct")) {
    var correct = document.getElementsByClassName("webex-correct").length;
    var solvemes = document.getElementsByClassName("webex-solveme").length;
    var radiogroups = document.getElementsByClassName("webex-radiogroup").length;
    var selects = document.getElementsByClassName("webex-select").length;
    
    t.innerHTML = correct + " of " + (solvemes + radiogroups + selects) + " correct";
  }
}

/* webex-solution button toggling function */
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
    my_answer = my_answer.replace(/ /g, "")
  }

  if (my_answer == "") {
    cl.remove("webex-correct");
    cl.remove("webex-incorrect");
  } else if (real_answers.includes(my_answer)) {
    cl.add("webex-correct");
    cl.remove("webex-incorrect");
  } else {
    cl.add("webex-incorrect");
    cl.remove("webex-correct");
  }

  // match numeric answers within a specified tolerance
  if(this.dataset.tol > 0){
    var tol = JSON.parse(this.dataset.tol);
    var matches = real_answers.map(x => Math.abs(x - my_answer) < tol)
    if (matches.reduce((a, b) => a + b, 0) > 0) {
      cl.add("webex-correct");
    } else {
      cl.remove("webex-correct");
    }
  }

  // added regex bit
  if (cl.contains("regex")){
    answer_regex = RegExp(real_answers.join("|"))
    if (answer_regex.test(my_answer)) {
      cl.add("webex-correct");
    }
  }

  update_total_correct();
}

/* function for checking select answers */
select_func = function(e) {
  var cl = this.classList
  
  /* add style */
  cl.remove("webex-incorrect");
  cl.remove("webex-correct");
  if (this.value == "answer") {
    cl.add("webex-correct");
  } else if (this.value != "blank") {
    cl.add("webex-incorrect");
  }
  
  update_total_correct();
}

/* function for checking radiogroups answers */
radiogroups_func = function(e) {
  var checked_button = document.querySelector('input[name=' + this.id + ']:checked');
  var cl = checked_button.parentElement.classList;
  var labels = checked_button.parentElement.parentElement.children;
  
  /* get rid of styles */
  for (i = 0; i < labels.length; i++) {
    labels[i].classList.remove("webex-incorrect");
    labels[i].classList.remove("webex-correct");
  }
  
  /* add style */
  if (checked_button.value == "answer") {
    cl.add("webex-correct");
  } else {
    cl.add("webex-incorrect");
  }
  
  update_total_correct();
}

window.onload = function() {
  console.log("onload");
  /* set up solution buttons */
  var buttons = document.getElementsByTagName("button");

  for (var i = 0; i < buttons.length; i++) {
    if (buttons[i].parentElement.classList.contains('webex-solution')) {
      buttons[i].onclick = b_func;
    }
  }

  /* set up webex-solveme inputs */
  var solveme = document.getElementsByClassName("webex-solveme");

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
  
  /* set up radiogroups */
  var radiogroups = document.getElementsByClassName("webex-radiogroup");
  for (var i = 0; i < radiogroups.length; i++) {
    radiogroups[i].onchange = radiogroups_func;
  }
  
  /* set up selects */
  var selects = document.getElementsByClassName("webex-select");
  for (var i = 0; i < selects.length; i++) {
    selects[i].onchange = select_func;
  }

  update_total_correct();
}

</script>
