<script>
tc = function() {
  if (t = document.getElementById("total_correct")) {
    t.innerHTML =
      document.getElementsByClassName("correct").length + " of " +
      document.getElementsByClassName("solveme").length + " correct";
  }
}

window.onload = function() {
  /* set up solution buttons */
  var buttons = document.getElementsByTagName("button");
  var b_func = function() {
    var cl = this.parentElement.classList;
    if (cl.contains('open')) {
      cl.remove("open");
    } else {
      cl.add("open");
    }
  }
  for (var i = 0; i < buttons.length; i++) {
    if (buttons[i].parentElement.classList.contains('solution')) {
      buttons[i].onclick = b_func
    }
  }
  
  /* set up solveme inputs */
  tc();
  var solveme = document.getElementsByClassName("solveme");
  var solveme_func = function(e) {
    var real_answer = this.getAttribute("answer").trim();
    var my_answer = this.value;
    var cl = this.classList;
    if (cl.contains("ignorecase")) {
      real_answer = real_answer.toLowerCase();
      my_answer = my_answer.toLowerCase();
    }
    if (cl.contains("nospaces")) {
      real_answer = real_answer.replace(/ /g, "");
      my_answer = my_answer.replace(/ /g, "");
    }
    var linend = new RegExp(/\s*(:or:)\s*/, 'g')
    real_answer = real_answer.split(linend);
    if (my_answer !== "" & real_answer.includes(my_answer)) {
      cl.add("correct");
    } else {
      cl.remove("correct");
    }
    tc();
  }
  for (var i = 0; i < solveme.length; i++) {
    solveme[i].setAttribute("autocomplete","off");
    solveme[i].setAttribute("autocorrect", "off");
    solveme[i].setAttribute("autocapitalize", "off"); 
    solveme[i].setAttribute("spellcheck", "false");
    solveme[i].value = "";
    solveme[i].onkeyup = solveme_func;
    solveme[i].onchange = solveme_func;
  }
}
</script>
