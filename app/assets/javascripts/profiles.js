function submitResume() {
  document.forms['resume-form'].submit();
}

function toggleCheckbox(checkboxId) {
  var checkbox = document.getElementById(checkboxId);
  if (checkbox != null) {
    checkbox.checked = !checkbox.checked;
  }
}
