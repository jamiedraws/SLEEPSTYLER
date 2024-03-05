(function (global) {
	if ("app" in global) {
		app.require(["defer"], function () {
			const nav = app.createContext(app.defer);

			nav.addProperties({
				element: document.querySelector(".nav"),
				orderLink: document.querySelector(".nav__order"),
				show: function () {
					if (this.elementExists(this.element)) {
						this.element.classList.remove("nav--is-hidden");
					}
				},
				hide: function () {
					if (this.elementExists(this.element)) {
						this.element.classList.add("nav--is-hidden");
					}
				},
				slidePanel: function (toggle) {
					if (typeof toggle === "object") {
						const setToggleEvent = function (elements) {
							nav.listen(elements, setToggle);
						};

						const setToggle = function () {
							try {
								toggle.checked = false;
							} catch (e) {
								console.warn(e.message);
								return false;
							}
						};

						return setToggleEvent;
					} else {
						return false;
					}
				},
				setAriaExpanded: function () {
					let isExpanded = JSON.parse(
						this.getAttribute("aria-expanded")
					);
					let setState = isExpanded ? false : true;
					this.setAttribute("aria-expanded", setState);
				}
			});

			app.addProperty("nav", nav);

			nav.viewElement(
				{
					selector: ".header",
					state: "nav--is-fixed",
					neighbor: ".nav",
					ready: "nav--is-primed"
				},
				function (config) {
					this.classList.remove(config.state);

					if (nav.elementExists(nav.orderLink)) {
						nav.orderLink.classList.add("btn--order-contrast");
					}
				},
				function (config) {
					this.classList.add(config.state);

					if (nav.elementExists(nav.orderLink)) {
						nav.orderLink.classList.remove("btn--order-contrast");
					}

					if (!this.classList.contains(config.ready)) {
						this.classList.add(config.ready);
					}
				}
			);

			const slide = nav.slidePanel(
				document.querySelector("#nav__toggle")
			);
			if (slide) {
				slide(document.querySelectorAll(".nav a[href^='#']"));
				slide(document.querySelectorAll(".nav__underlay"));
			}

			nav.listen(
				document.querySelectorAll(".nav [aria-haspopup]"),
				nav.setAriaExpanded
			);

			const reveal = app.createContext(app.defer);

			reveal.addProperties({
				fetchOffscreen: function (config) {
					config.element.classList.add(config.state);
				},
				fetchOnscreen: function (config) {
					config.element.classList.remove(config.state);
				},
				getRekt: function (entry) {
					let rect = false;
					if (reveal.isObject(entry)) {
						rect = entry.boundingClientRect;
						if (!reveal.isObject(rect)) {
							rect = entry.target.getBoundingClientRect();
						}
					}
					return rect;
				},
				setElement: function (config, element) {
					const result = config.hasOwnProperty("element");
					if (!result) {
						Object.defineProperty(config, "element", {
							value: element
						});
					}
					return result;
				},
				toggleOffscreen: function (config) {
					let ypos = 0;
					let result = false;

					reveal.viewElement(
						config,
						function (config, element, entry) {
							if (!result) {
								result = reveal.setElement(config, this);
							}

							const pos = reveal.getRekt(entry);
							if (reveal.isObject(pos)) {
								if (pos.y > ypos) {
									reveal.fetchOnscreen(config);
								}
								ypos = pos.y;
							}
						},
						function (config, element, entry) {
							if (!result) {
								result = reveal.setElement(config, this);
							}

							const pos = reveal.getRekt(entry);
							if (reveal.isObject(pos)) {
								if (pos.y < ypos) {
									reveal.fetchOffscreen(config);
								}
								ypos = pos.y;
							}
						}
					);

					return config;
				},
				toggleOnscreen: function (config) {
					let ypos = 0;
					let result = false;

					reveal.viewElement(
						config,
						function (config, element, entry) {
							if (!result) {
								result = reveal.setElement(config, this);
							}

							const pos = reveal.getRekt(entry);
							if (reveal.isObject(pos)) {
								if (pos.y < ypos) {
									reveal.fetchOnscreen(config);
								}
								ypos = pos.y;
							}
						},
						function (config, element, entry) {
							if (!result) {
								result = reveal.setElement(config, this);
							}

							const pos = reveal.getRekt(entry);
							if (reveal.isObject(pos)) {
								if (pos.y > ypos) {
									reveal.fetchOffscreen(config);
								}
								ypos = pos.y;
							}
						}
					);

					return config;
				}
			});

			app.addProperty("reveal", reveal);

			addEventListener("load", function () {
				const offscreen = reveal.toggleOffscreen({
					selector: ".reveal-offscreen",
					state: "reveal--is-visible",
					neighbor: ".reveal"
				});
				const onscreen = reveal.toggleOnscreen({
					selector: ".reveal-onscreen",
					state: "reveal--is-visible",
					neighbor: ".reveal"
				});
			});
		});
	}
})(window);
