class BuildingFormController extends AppController {
  static get targets() {
    return [
      "errorMessages",
      "buildingUuid",
      "name",
      "hasIndividualLetterboxes",
      "hasIndividualIntercoms",
      "address",
      "numberOfApartments",
      "neighborhood"
    ];
  }

  get name() {
    return this.nameTarget.value;
  }

  get buildingUuid() {
    return this.buildingUuidTarget.value;
  }

  get hasIndividualLetterboxes() {
    return this.hasIndividualLetterboxesTarget.value;
  }

  get hasIndividualIntercoms() {
    return this.hasIndividualIntercomsTarget.value;
  }

  get address() {
    return this.addressTarget.value;
  }

  get numberOfApartments() {
    return this.numberOfApartmentsTarget.value;
  }

  get neighborhood() {
    return this.neighborhoodTarget.value;
  }

  get payload() {
    const { neighborhood, address, name } = this;
    const number_of_apartments = this.numberOfApartments;
    const has_individual_letterboxes = this.hasIndividualLetterboxes;
    const has_individual_intercoms = this.hasIndividualIntercoms;

    return {
      building: {
        name,
        neighborhood,
        address,
        number_of_apartments,
        has_individual_letterboxes,
        has_individual_intercoms
      }
    };
  }

  saveBuilding(e) {
    e.preventDefault();
    this.startLoader();

    apiPatch(`/api/buildings/${this.buildingUuid}`, this.payload)
      .then((response, other) => {
        return response.json().then(jsonResponse => {
          this.handleResponse(jsonResponse, response);
        });
      })
      .catch(error => alert("Ooops, algo deu errado."));
  }

  handleResponse(jsonResponse, response) {
    if (response.status >= 200 && response.status < 300) {
      Turbolinks.visit("/buildings");
      return;
    }

    const feedback = this.errorMessagesTarget;
    feedback.innerHTML = jsonResponse.message;
    this.showElement(feedback);
    this.stopLoader();
  }
}
