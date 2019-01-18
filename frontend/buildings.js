import { Application } from "stimulus";
import Turbolinks from "turbolinks";

import ApartamentRemovalController from "./app/controllers/apartment_removal_controller";
import ApartmentsController from "./app/controllers/apartments_controller";
import ContactAttemptController from "./app/controllers/contact_attempt_controller";
import DialogController from "./app/controllers/dialog_controller";
import BuildingFormController from "./app/controllers/building_form_controller";

const application = Application.start();
application.register("apartments", ApartmentsController);
application.register("contact-attempt", ContactAttemptController);
application.register("dialog", DialogController);
application.register("building_form", BuildingFormController);
application.register("apartment_removal", ApartamentRemovalController);

Turbolinks.start();
