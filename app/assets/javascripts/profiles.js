
function submitProfile() {
  document.forms['profile-form'].submit();
}

function toggleCheckbox(checkboxId) {
  var checkbox = document.getElementById(checkboxId);
  if (checkbox != null) {
    checkbox.checked = !checkbox.checked;
  }
}
