//  trix editors
window.addEventListener("trix-file-accept", function (event) {
    //constants
  const acceptedTypes = ["image/jpeg", "image/png"];
  const maxFileSize = 1024 * 1024 // 1MB 

    // whilte list
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault();
    alert("Autorise uniquement de joindre que des fichiers de type jpeg ou png.");
  }
  // file size
  if (event.file.size > maxFileSize) {
    event.preventDefault()
    alert("La tialle du fichier ne peut pas dépassée 1MB!")
  }
});


