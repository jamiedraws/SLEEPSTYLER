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

    // This will only be offered for the answer choice "Doesn't seem like a good value." If that answer is selected, we are going to offer the 10% off discount site version.
    const meetsCriteriaForAnswerCombo1 = function ($survey) {
        return hasSurveyAnswerById($survey, "NOVALUE");
    };

    const meetsCriteriaForAnswerCombo2 = function ($survey) {
        return hasSurveyAnswerById($survey, "BRB");
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
            "https://www.sunjoextream.com/SJOXTREAM/10.0000/Index.dtm?mid=" +
            mid +
            "&_vsv=";
        response.id = "discount";
        response.description =
            "Order in the next 30 minutes and get an additional 10% off the Sun Joe SPX3000 XTREAM offer - Now Only $215.99 with free shipping";

        return response;
    };

    // create response message based on the criteria tests
    const createResponseByCriteria = function () {
        const $survey = postOrderSurvey.select.survey;
        let response = createSubmitResponse();

        if (meetsCriteriaForAnswerCombo1($survey)) {
            response = createDiscountResponse(response, "11957322");
        } else if (meetsCriteriaForAnswerCombo2($survey)) {
            response = createDiscountResponse(response, "11968182");
        }

        return response;
    };

    // if the response object is identified as a discount offer
    const isAnswerComboResponse = function (response) {
        return response.id === "discount";
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
