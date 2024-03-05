import Modal from "Shared/ts/components/modal";

import ModalDialogIframe from "Shared/ts/api/modal/modal-dialog-iframe";

import { observer } from "Shared/ts/observers/intersection";
import ElementController from "Shared/ts/utils/element-controller";

const modalRepository: WeakMap<HTMLElement, Modal> = new WeakMap<
    HTMLElement,
    Modal
>();

window.modalRepo = modalRepository;

const modalInitializerStatus: WeakMap<HTMLElement, boolean> = new WeakMap<
    HTMLElement,
    boolean
>();

const initiateDocumentModalDialogsByControllers = () => {
    const controllers: Element[] = Array.from(
        document.querySelectorAll(
            `[data-modal-dialog-type=document][data-modal-dialog-actor=open][data-modal-dialog-id][data-modal-dialog-title]`
        )
    ).filter(
        (controller, index, controllers) =>
            controllers.indexOf(controller) === index
    );

    const containers = controllers
        .map((controller) =>
            document.querySelector(
                `#${controller.getAttribute("data-modal-dialog-id")}`
            )
        )
        .filter((container) => container !== null) as HTMLElement[];

    containers.forEach((container) => {
        const label = controllers.find(
            (controller) =>
                container.id ===
                controller?.getAttribute("data-modal-dialog-id")
        );

        if (!label || modalInitializerStatus.has(container)) return;

        modalInitializerStatus.set(container, true);

        const modal = new Modal(container as HTMLElement, {
            ariaLabel: label.getAttribute("data-modal-dialog-title") ?? ""
        });

        modalRepository.set(container, modal);
    });
};

initiateDocumentModalDialogsByControllers();

const initiateDocumentModalDialogsByContainers = () => {
    const containers: HTMLElement[] = Array.from(
        document.querySelectorAll(
            "[data-modal-dialog-container][data-modal-dialog-title]"
        )
    );

    containers.forEach((container) => {
        if (modalInitializerStatus.has(container)) return;

        modalInitializerStatus.set(container, true);

        const modal = new Modal(container, {
            ariaLabel: container.getAttribute("data-modal-dialog-title") ?? ""
        });

        modalRepository.set(container, modal);
    });
};

initiateDocumentModalDialogsByContainers();

const modalDialogIframe = new ModalDialogIframe();
modalDialogIframe.initializeObserver();
