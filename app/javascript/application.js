// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import { Sidebar, Contact } from "./layout_scripts"

Sidebar()
Contact()