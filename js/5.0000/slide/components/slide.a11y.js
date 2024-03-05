Slide.proto({
	updateSlideVisibility: function (index) {
		const self = this;
		const children = this.toArray(this.children);
		children.forEach(function (child, i) {
			const state = i === index ? "false" : "true";
			child.setAttribute("aria-hidden", state);
			self.updateFocusableItems(child, "a");
			self.updateFocusableItems(child, "button");
		});
	},
	updateFocusableItems: function (element, selector) {
		const items = this.toArray(element.querySelectorAll(selector));
		if (element.ariaHidden === "true") {
			items.forEach(function (item) {
				item.tabIndex = -1;
			});
		} else {
			items.forEach(function (item) {
				item.tabIndex = 0;
			});
		}
	},
	setAllSlidesToVisible: function () {
		const self = this;
		const children = this.toArray(this.children);
		children.forEach(function (child) {
			child.setAttribute("aria-hidden", "false");
			self.updateFocusableItems(child, "a");
			self.updateFocusableItems(child, "button");
		});
	},
	observeLiveRegion: function () {
		const state = this.isAuto() ? "off" : "polite";
		this.parent.setAttribute("aria-live", state);
	}
});
