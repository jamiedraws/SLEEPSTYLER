(function (global) {
	if ("app" in global) {
		const defer = app.createContext(app);

		defer.addProperties({
			updateContainer: function (placeholder, element, state) {
				let operation = state === true ? "add" : "remove";

				if (
					this.elementExists(placeholder) &&
					this.elementExists(element)
				) {
					placeholder.classList[operation]("defer--success");
					element.classList[operation]("defer__success");
				}
			},
			setContainer: function (placeholder) {
				const element = placeholder.querySelector(".defer__progress");

				return Object.create(
					{},
					{
						show: {
							value: this.updateContainer.bind(
								this,
								placeholder,
								element,
								true
							)
						},
						hide: {
							value: this.updateContainer.bind(
								this,
								placeholder,
								element,
								false
							)
						}
					}
				);
			},
			revealContainers: function () {
				const placeholders = app.toArray(
					document.querySelectorAll(".defer")
				);
				placeholders.forEach(function (placeholder) {
					const container = defer.setContainer(placeholder);
					container.show();
				});
			},
			isAvailable: function (selector, response) {
				let result = response || false;
				if (this.isString(selector)) {
					const element = document.querySelector(selector);
					if (this.elementExists(element)) {
						result = element;
					}
				}
				return result;
			},
			viewElement: function (config, inRangeCallback, outRangeCallback) {
				if (this.isObject(config)) {
					let element = this.isAvailable(config.selector);

					if (element && this.isString(config.state)) {
						element = this.isAvailable(config.neighbor, element);

						if (app.require(["observer"])) {
							const func = function () {},
								inRange = inRangeCallback || func,
								outRange = outRangeCallback || func;

							app.observer.watch({
								selector: config.selector,
								inRange: inRange.bind(element, config),
								outRange: outRange.bind(element, config),
								unObserve: false
							});
						}
					}
				}
			}
		});

		app.require(["observer"], function () {
			app.require(["lazy"], function () {
				app.observer.watch({
					selector: "[data-src-img]",
					inRange: function (loadItem) {
						defer.lazy(loadItem);
					}
				});

				app.observer.watch({
					selector: "[data-src-iframe]",
					inRange: function (record) {
						defer.lazy(record, {
							tag: "iframe",
							src: "data-src-iframe",
							ondemand: true
						});
					}
				});
			});

			app.observer.watch({
				selector: ".view--remove-nav",
				inRange: function () {
					if (app.require(["nav"])) {
						app.nav.hide();
					}
				},
				outRange: function () {
					if (app.require(["nav"])) {
						app.nav.show();
					}
				},
				unObserve: false,
				options: {
					threshold: 0.1
				}
			});
		});

		defer.lock();
		app.addProperty("defer", defer);

		const toast = app.createContext(app);

		toast.addProperties({
			hide: function () {
				if (this.require(["element"])) {
					this.element.classList.add("toast--hidden");
				}
			},
			show: function () {
				if (this.require(["element"])) {
					this.element.classList.remove("toast--hidden");
				}
			},
			handleCloseButton: function (element) {
				const close = element.querySelector(".toast__close");
				if (this.elementExists(close)) {
					this.listen(close, this.hide.bind(this));
				}
			},
			register: function (id) {
				let element = false;

				if (this.isString(id)) {
					element = document.getElementById(id);
					if (this.elementExists(element)) {
						this.addProperty("element", element);
						element.classList.add("toast--is-ready");
						this.handleCloseButton(element);
					}
				}

				return this.publicInterface(element);
			},
			publicInterface: function (element) {
				return Object.create(
					{},
					{
						element: {
							value: element
						},
						show: {
							value: this.show.bind(this)
						},
						hide: {
							value: this.hide.bind(this)
						}
					}
				);
			}
		});

		app.addProperty("toast", toast.register.bind(toast));

		app.listen(
			document.querySelectorAll(".expando > .expando__toggle"),
			function () {
				this.classList.toggle("expando--is-selected");
				if (this.classList.contains("btn")) {
					this.classList.toggle("btn--is-active");
				}
			}
		);

		const order = app.createContext(app);

		order.addProperties({
			root: document.querySelector("html"),
			error: document.getElementById("order"),
			vse: document.querySelector(".validation-summary-errors"),
			buttons: order.toArray(
				document.querySelectorAll("[href^='#order']")
			),
			showButtons: function () {
				this.buttons.forEach(function (button) {
					if (button.classList.contains("defer-input")) {
						button.classList.add("defer-input--ready-for-input");
					}
				});
			},
			updateScrollBehavior: function () {
				this.root.classList.toggle("scroll-behavior-auto");
			},
			init: function () {
				this.showButtons();

				if (this.elementExists(this.vse)) {
					this.updateScrollBehavior();
					this.scrollToErrors();
					this.updateScrollBehavior();
				}
			},
			scrollToErrors: function () {
				if (this.elementExists(this.error)) {
					this.error.scrollIntoView();
				}
			}
		});

		order.lock();
		order.init();
		app.addProperty("order", order);
	}

	addEventListener("DOMContentLoaded", function () {
		const m = modal({
			modal: {
				value: document.querySelector(".modal")
			},
			text: {
				value: document.querySelector(".modal__text")
			},
			stateClass: {
				value: "modal--is-visible"
			},
			focusElement: {
				value: document.querySelector(".modal__button")
			}
		});

		// apply modal
		addEventListener("beforeunload", m.show.bind(m));
		addEventListener("submit", m.show.bind(m));
		if (app.elementExists(m.focusElement)) {
			m.focusElement.addEventListener("click", m.hide.bind(m));
		}
	});

	Object.defineProperty(global, "makeToast", {
		value: (function () {
			let toast;

			if ("app" in window) {
				toast = app.createContext(app);

				toast.addProperties({
					store: [],
					hasToast: function () {
						return app.require(["toast"]);
					},
					registerTemplates: function () {
						const templates = this.toArray(
							document.querySelectorAll(".toast")
						);

						templates.forEach(function (template) {
							toast.store.push({
								id: template.id,
								api: app.toast(template.id)
							});
						});
					},
					getTemplateById: function (id) {
						let result = false;

						this.store.forEach(function (template) {
							if (template.id === id) {
								result = template;
							}
						});

						return result;
					},
					show: function (id) {
						const template = this.getTemplateById(id);
						if (template) {
							template.api.show();
						}
					},
					getTemplateAPI: function (id) {
						const template = this.getTemplateById(id);
						return template.api;
					},
					updateMessage: function (id, message) {
						const template = this.getTemplateById(id);

						if (template) {
							const element = template.api.element;
							const title = element.querySelector(
								"#" + template.id + "-title"
							);
							title.innerHTML = message;
						}
					},
					processTask: function () {
						if (this.hasToast()) {
							this.registerTemplates();
						}
					}
				});

				toast.processTask();
			}

			return function (id, message) {
				let response = false;

				if (toast && toast.hasToast()) {
					toast.updateMessage(id, message);
					toast.show(id);
					response = toast.getTemplateAPI(id);
				}

				return response;
			};
		})()
	});
})(window);
