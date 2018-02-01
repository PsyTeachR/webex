<script>
tc = function() {
	if (t = document.getElementById("total_correct")) {
	    t.innerHTML =
		document.getElementsByClassName("correct").length + " of " +
		document.getElementsByClassName("solveme").length + " correct";
	}
    }
window.onload = function() {
    var buttons = document.getElementsByTagName("button");
    for (var i = 0; i < buttons.length; i++) {
	buttons[i].onclick = function() {
	    var cl = this.parentElement.classList;
	    if (cl.contains('open')) {
		cl.remove("open");
	    } else {
		cl.add("open");
	    }
	}
    }
    tc();
    var solveme = document.getElementsByClassName("solveme");
    for (var i = 0; i < solveme.length; i++) {
	solveme[i].setAttribute("autocomplete","off");
	solveme[i].value = "";
	solveme[i].onkeyup = function(e) {
	    var real_answer = this.getAttribute("answer").trim();
	    var my_answer = this.value;
	    var cl = this.classList;
	    if (cl.contains("nospaces")) {
		real_answer = real_answer.replace(/ /g, "");
		my_answer = my_answer.replace(/ /g, "");
	    }
	    if (cl.contains("ignorecase")) {
		real_answer = real_answer.toLowerCase();
		my_answer = my_answer.toLowerCase();
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
	solveme[i].onchange = function() {
	    this.onkeyup();
	}
    }
}
</script>
