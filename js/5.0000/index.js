(function (global) {
	if ("app" in global) {
		app.require(["defer"], function () {
			const media = app.createContext(app);

			media.addProperties({
				root: document.querySelector(".media"),
				selectedState: "btn--is-active",
				hasSource: function () {
					return media.isString(media.getSource(element));
				},
				getSource: function (element) {
					return element.dataset.srcIframe;
				},
				updateSource: function (element, id) {
					const source = media.getSource(element);
					return source.replace(/(\d{9})/, id);
				},
				getId: function (element) {
					return element.dataset.videoId;
				},
				getIframe: function (element) {
					return element.querySelector("iframe");
				},
				hasVimeo: function () {
					return "Vimeo" in global;
				},
				setVimeo: function (iframe, options) {
					let result = false;
					if (media.hasVimeo() && media.elementExists(iframe)) {
						result = new Vimeo.Player(iframe, options);
					}
					return result;
				},
				getCurrentButton: function (button) {
					const lastSelectedButton = media.root.querySelector(
						"." + media.selectedState
					);
					if (media.elementExists(lastSelectedButton)) {
						lastSelectedButton.classList.remove(
							media.selectedState
						);
					}
					button.classList.add(media.selectedState);
				},
				updateVideo: function (id) {
					if (media.isString(id)) {
						const source = media.updateSource(media.video, id);

						if (media.vimeo) {
							media.vimeo
								.loadVideo(id)
								.then(media.playVideo)
								.catch(function (error) {
									console.log(error);
								});
						} else {
							const iframe = media.getIframe(media.video);
							if (media.elementExists(iframe)) {
								iframe.src = source;
							}
						}
					}
				},
				playVideo: function () {
					if (
						media.isObject(media.vimeo) &&
						!media.isActive &&
						media.isUserPause
					) {
						media.vimeo.play();
					}
				},
				pauseVideo: function () {
					if (
						media.isObject(media.vimeo) &&
						media.isActive &&
						media.isUserPlay
					) {
						media.vimeo.pause();
					}
				},
				hasIframe: function (element) {
					return media.elementExists(media.getIframe(element));
				},
				handleEvents: function () {
					const buttons = media.root.querySelectorAll(
						"[data-video-id]"
					);

					media.listen(buttons, function () {
						const id = media.getId(this);
						media.getCurrentButton(this);
						media.updateVideo(id);
					});

					if (media.isObject(media.vimeo)) {
						media.vimeo.on("play", function () {
							media.isActive = true;
							media.isUserPlay = true;
							media.isUserPause = false;
						});

						media.vimeo.on("pause", function () {
							media.isActive = false;
							media.isUserPlay = false;
							media.isUserPause = true;
						});
					}
				},
				processor: (function () {
					let init = false;

					return function (element) {
						if (media.hasIframe(element)) {
							if (!media.vimeo) {
								const vimeo = media.setVimeo(
									media.getIframe(element)
								);
								media.addProperty("vimeo", vimeo);
							}

							if (!media.video) {
								media.addProperty("video", element);
							}

							if (!init) {
								init = true;
								media.handleEvents();
							} else {
								media.playVideo();
							}
						} else {
							setTimeout(
								media.processor.bind(media, element),
								1000
							);
						}
					};
				})()
			});

			const features = app.createContext(app.defer);

			const circularReveal = function (element, inner) {
				if (app.elementExists(element) && app.elementExists(inner)) {
					const easing = 0.1;
					const outScale = 0.01;
					const inScale = 1;
					let targetScale = outScale;
					let elementScale = targetScale;
					let innerScale = 1 / elementScale;

					let animate = false;

					const update = function () {
						elementScale += (targetScale - elementScale) * easing;
						innerScale = 1 / elementScale;

						element.style.transform = "scale(" + elementScale + ")";
						inner.style.transform = "scale(" + innerScale + ")";

						if (animate) {
							requestAnimationFrame(update);
						} else {
							cancelAnimationFrame(update);
						}
					};

					return {
						show: function () {
							targetScale = inScale;
						},
						hide: function () {
							targetScale = outScale;
						},
						animate: function () {
							animate = true;
							update();
						},
						deanimate: function () {
							animate = false;
							update();
						}
					};
				}
			};

			features.addProperties({
				featuresReveal: circularReveal(
					document.querySelector(".features__reveal"),
					document.querySelector(".features__reveal__image")
				)
			});

			app.require(["observer"], function () {
				app.observer.watch({
					selector: ".features",
					inRange: features.featuresReveal.animate.bind(features),
					outRange: features.featuresReveal.deanimate.bind(features),
					unObserve: false
				});

				app.observer.watch({
					selector: ".features",
					inRange: function () {
						features.addProperties({
							figure: document.querySelector(
								".features__picture"
							),
							list: document.querySelector(".features__list"),
							buttons: document.querySelectorAll(
								".features__picture button"
							),
							features: document.querySelectorAll(
								".features__interactive-list li"
							),
							prime: "features--is-primed",
							state: "features--is-selected",
							pictures: document.querySelectorAll(
								".features__reveal picture"
							),
							setPrime: function () {
								features.list.classList.add(
									"features--is-primed"
								);
								features.selectFeature.call(
									document.activeElement
								);
							},
							unsetPrime: function () {
								features.list.classList.remove(
									"features--is-primed"
								);
								features.toggleFeatures();
								if (
									features.isObject(features.featuresReveal)
								) {
									features.featuresReveal.hide();
								}
							},
							toggleFeatures: function (element) {
								features
									.toArray(features.features)
									.forEach(function (feature) {
										if (feature === element) {
											feature.classList.add(
												features.state
											);
										} else {
											feature.classList.remove(
												features.state
											);
										}
									});
							},
							selectFeature: function () {
								const label = this.getAttribute(
									"aria-labelledby"
								);
								if (features.isString(label)) {
									const element = document.getElementById(
										label
									);
									if (features.elementExists(element)) {
										features.toggleFeatures(element);
									}
									features.togglePictures(label);
								}
							},
							toggleButtons: function (id) {
								features
									.toArray(features.buttons)
									.forEach(function (button) {
										const label = button.getAttribute(
											"aria-labelledby"
										);
										if (label === id) {
											button.classList.add(
												features.state
											);
										} else {
											button.classList.remove(
												features.state
											);
										}
									});
							},
							togglePictures: function (id) {
								if (
									features.isObject(features.featuresReveal)
								) {
									features
										.toArray(features.pictures)
										.forEach(function (picture) {
											const label = picture.getAttribute(
												"aria-labelledby"
											);
											if (label === id) {
												picture.classList.add(
													features.state
												);
												features.featuresReveal.show();
												app.require(
													["lazy"],
													function () {
														app.lazy(picture);
													}
												);
											} else {
												picture.classList.remove(
													features.state
												);
											}
										});
								}
							}
						});

						features.listen(
							features.figure,
							features.setPrime,
							"mouseenter"
						);

						features.listen(
							features.list,
							features.setPrime,
							"mouseenter"
						);

						features.listen(
							features.figure,
							features.unsetPrime,
							"mouseleave"
						);

						features.listen(
							features.list,
							function () {
								features.unsetPrime();
								features.toggleButtons();
								features.togglePictures();
							},
							"mouseleave"
						);

						features.listen(
							features.buttons,
							features.selectFeature
						);

						features.listen(
							features.buttons,
							features.selectFeature,
							"mouseover"
						);

						features.listen(
							features.buttons,
							function () {
								features.featuresReveal.hide();
								features.toggleFeatures();
							},
							"mouseleave"
						);

						features.listen(
							features.buttons,
							features.selectFeature,
							"focus"
						);

						features.listen(
							features.features,
							function () {
								features.toggleFeatures(this);
								features.toggleButtons(this.id);
								features.togglePictures(this.id);
							},
							"mouseenter"
						);
					}
				});

				app.observer.watch({
					selector: ".media__video",
					inRange: media.processor.bind(media),
					outRange: media.pauseVideo,
					unObserve: false,
					options: {
						threshold: 1.0
					}
				});

				app.observer.watch({
					selector: "[data-src-photobar]",
					inRange: function (photobar) {
						app.require(["lazy"], function () {
							app.lazy(photobar, {
								src: "data-src-photobar"
							});
						});
					},
					options: {
						threshold: 0.5
					}
				});
			});
		});
	}
})(window);
