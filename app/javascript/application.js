// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import 'boxicons'

import "./src/jquery"
import 'jquery-ui'

let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
  return new bootstrap.Popover(popoverTriggerEl)  
})

import "@nathanvda/cocoon"

import '@client-side-validations/client-side-validations/src'
import './rails.validations'

import './template/bootstrap.bundle.min.js'
import './custom/toast.js'
