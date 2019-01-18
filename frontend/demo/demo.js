import 'babel-core/register'
import 'babel-polyfill'

import { Application } from "stimulus"

import DemoController from "./demo_controller";
const application = Application.start()
application.register("demo", DemoController)
