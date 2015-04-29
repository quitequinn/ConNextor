
var expertiseChecked = {};

function updateExpertise(expertise, checkboxId) {
  // update hash
  expertiseChecked[expertise] = true;

  // update checkbox
  toggleCheckbox(checkboxId);

  // populate
  var image = "";
  for (var key in expertiseChecked) {
    if (expertiseChecked[key]) {
      if (image !== "") {
        image += ", "
      }
      image += key;
    }
  }

  // update field
  document.getElementById('expertise-image').value = image;
}

