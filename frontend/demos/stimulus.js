import "@stimulus/polyfills";
import { Application } from "stimulus";
import DemoController from "./stimulus/demo_controller";

const application = Application.start();
application.register("demo", DemoController);
