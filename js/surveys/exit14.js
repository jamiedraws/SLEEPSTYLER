if ("_surveyEngine" in window) {
    // add the answer combo response template to the post order survey interface
    const addAnswerComboTemplate = function () {
        postOrderSurvey.addTemplate(
            "answerComboResponse",
            $("#modal__answer-combo-response"),
            false
        );
    };

    // determine if there's a selected answer based on the form controls' id attribute
    const hasSurveyAnswerById = function ($survey, id) {
        const $answer = $survey.find("#" + id);
        return $answer.is(":checked");
    };

    // determine if there's a selected answer(s) based on the form control's name attribute
    const hasSurveyAnswerByName = function ($survey, name, compare) {
        const $answers = $survey.find('[name="' + name + '"]:checked');
        return typeof compare === "function"
            ? compare($answers.length)
            : (function () {
                  return $answers.length > 0;
              })();
    };

    // This will only be offered for the answer choice "I'll be back! I'm just not ready to order yet" If that answer is selected, we are going to show the image for that offer.
    const meetsCriteriaForNotReady = function ($survey) {
        return hasSurveyAnswerById($survey, "BRB");
    };

    // This will only be offered for the answer choice "I want to buy it/see it at the store." If that answer is selected, we are going to show the image for that offer.
    const meetsCriteriaAtStore = function ($survey) {
        return hasSurveyAnswerById($survey, "STORE");
    };

    const meetsCriteriaNoValue = function ($survey) {
        return hasSurveyAnswerById($survey, "NOVALUE");
    };

    // create new response object
    const createSubmitResponse = function () {
        return {
            id: "success",
            title: "Thank you for your response.",
            description: "",
            url: "",
            close: true
        };
    };

    // create discount offer response
    const createDiscountResponse = function (response, mid) {
        response.url =
            "https://www.sunjoextream.com/SJOXTREAM/16.0000/Index.dtm?mid=" +
            mid +
            "&_vsv=";
        response.id = "discount";
        response.description = "Don't Miss Out! Special Introductory Offer!";

        return response;
    };

    // create discount offer response
    const createStoreResponse = function (response, mid) {
        response.url =
            "https://www.sunjoextream.com/SJOXTREAM/16.0000/Index.dtm?mid=" +
            mid +
            "&_vsv=";
        response.id = "store";
        response.description = "SKIP THE HASSLE OF GOING TO THE STORE, SUN JOE SHIPS RIGHT TO YOUR FRONT DOOR!";

        return response;
    };

    // create novalue offer response
    const createNoValueResponse = function (response, mid) {
        response.url =
            "https://www.sunjoextream.com/SJOXTREAM/16.0000/Index.dtm?mid=" +
            mid +
            "&_vsv=";
        response.id = "novalue";
        response.description = "Special Introductory Offer!";

        return response;
    };

    // used for defaulting all answers to this offer
    const createResponseForAll = function (response, mid) {
        response.url =
            "https://www.sunjoextream.com/SJOXTREAM/16.0000/Index.dtm?mid=" +
            mid +
            "&_vsv=";
        response.id = "novalue";
        response.description = "Special Introductory Offer!";

        return response;
    };

    // create response message based on the criteria tests
    const createResponseByCriteria = function () {
        const $survey = postOrderSurvey.select.survey;
        let response = createSubmitResponse();

        // if (meetsCriteriaForNotReady($survey)) {
        //     response = createDiscountResponse(response, "11968182");
        // }
        
        // if (meetsCriteriaAtStore($survey)) {
        //     response = createStoreResponse(response, "12087287");
        // }

        // if (meetsCriteriaNoValue($survey)) {
        //     response = createNoValueResponse(response, "11957322");
        // }

        response = createResponseForAll(response, "12094462");

        return response;
    };

    // if the response object is identified as a discount offer
    const isAnswerComboResponse = function (response) {
        if (response.id == "discount" || response.id == "store" || response.id == "novalue") {
            return true;
        } else {
            return false;
        }
    };

    // override public postSubmit method to customize response message
    _surveyEngine.postSubmit = function () {
        const response = createResponseByCriteria();
        const template = isAnswerComboResponse(response)
            ? "answerComboResponse"
            : "response";

        postOrderSurvey
            .addResponse({
                addTemplate: postOrderSurvey.template[template],
                addResponse: response
            })
            .then(function ($reference) {
                postOrderSurvey.displayModal(
                    postOrderSurvey.select.survey,
                    false
                );

                setTimeout(function () {
                    postOrderSurvey.displayModal(
                        postOrderSurvey.select.loader,
                        false
                    );

                    postOrderSurvey.displayModal($reference, true);
                    $reference.find("[tabindex]:first").focus();
                }, 1500);
            });
    };

    addEventListener("load", addAnswerComboTemplate);
}
