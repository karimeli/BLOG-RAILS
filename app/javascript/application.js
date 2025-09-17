import { Turbo } from "@hotwired/turbo-rails"
import "controllers";
// Inicializa CKEditor cuando la página se cargue
document.addEventListener("turbo:load", () => {
  const editorElements = document.querySelectorAll('.ckeditor');
  editorElements.forEach(element => {
    ClassicEditor.create(element)
      .then(editor => {
        console.log('CKEditor inicializado');
      })
      .catch(error => {
        console.error('Error al inicializar CKEditor:', error);
      });
  });
});
