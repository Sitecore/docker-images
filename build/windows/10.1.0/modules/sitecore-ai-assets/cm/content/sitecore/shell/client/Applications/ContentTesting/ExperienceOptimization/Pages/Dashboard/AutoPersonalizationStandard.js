require.config({
    baseUrl: "/",
    paths: {
        "moment": "/sitecore/shell/client/Speak/Assets/lib/ui/1.1/deps/moment/moment.min"
    }
});

define(["sitecore", "moment", "userProfile"], function (_sc, moment) {
    var models = _sc.D3.models;

    models.colors.standardColors = ["#DF7C77", "#EFBDBB"].concat(models.colors.standardColors);

    models.formatterConfig.dateFormatter = function (options) {
        return function (date) {
            return getFormattedDate(date);
        };
    };

    models.utils.ellipse = (function () { //Adjust for angled labels
        var cached_function = models.utils.ellipse;
        return function () {
            return cached_function.apply(this, arguments[0][0][0].classList.contains("nv-legend-text") ? arguments : [arguments[0], 70, 2, 2]);
        };
    })();

    models.nvd3Axis.removeOverlappingLabels = function (canvas, hasBarInCombinationChart, dataLength, chartType) {
        return dataLength;
    };

    ["Area", "Column"].forEach(function (chartType) {
        _sc.D3.components[chartType].prototype.initChart = (function () {
            var cached_function = _sc.D3.components[chartType].prototype.initChart;
            return function () {
                this.ChartProperties.margin.bottom += 15;
                return cached_function.apply(this, arguments);
            };
        })();
    });

    getTypes = function (includeComponent) {
        var types = ["Traffic", "AverageTev", "AverageTevByPage", "BounceRate"];
        return includeComponent ? types.concat("Component") : types;
    }

    getFormattedDate = function (date) {
        return date.toLocaleDateString(__speak_config_active_culture,
            {
                year: 'numeric',
                month: 'short',
                day: 'numeric'
            })
    }

    var AutoPersonalizationStandard = _sc.Definitions.App.extend({

        initialize: function () {
        },

        initialized: function () {
            this.initializeErrorListeners();
            this.reparentProgressIndicators();
            this.ComponentListBox.once("change:items", function () {
                this.populateLists();
                this.initializeListenersForLabelUpdate();
                this.setListBoxSelectedItems();
                this.initializeListenersForChartLoad();
                this.refreshCharts();
            }.bind(this));

            this.getData("ComponentDropdown", null, null, "ComponentListBox", "ComponentDataProvider");
            this.regulateDropDowns();
            this.getWarnings();
        },

        initializeErrorListeners: function () {
            this.MessageBarDataProvider.on("error", this.showError.bind(this));
            this.TrafficChartDataProvider.on("error", this.showError.bind(this));
            this.ComponentDataProvider.on("error", this.showError.bind(this));
            this.AverageTevChartDataProvider.on("error", this.showError.bind(this));
            this.AverageTevByPageChartDataProvider.on("error", this.showError.bind(this));
            this.BounceRateChartDataProvider.on("error", this.showError.bind(this));
        },

        getWarnings: function () {
            this.getData("Warning", null, null, "AutoPersStandardMessageBar", "MessageBarDataProvider");
        },

        showError: function () {
            this.AutoPersStandardMessageBar.addMessage("error", { text: "A request to the server has failed", actions: [], closable: true })
        },

        refreshCharts() {
            getTypes().forEach(function (chart) {
                this.loadChart(chart);
            }.bind(this));
        },

        initializeListenersForLabelUpdate: function () {
            getTypes(true).forEach(function (type) {
                this[type + "ListBox"].on("change:selectedItem", function () {
                    var item = this[type + "ListBox"].attributes.selectedItem || {};
                    var text = item.range || item.label;
                    text && this[type + "DropDown"].set("text", text);
                }.bind(this));
            }.bind(this));
        },

        initializeListenersForChartLoad: function () {
            getTypes(true).forEach(function (type) {
                this[type + "ListBox"].on("change:selectedItem", this.loadChart.bind(this, type));
            }.bind(this));
            this.ComponentListBox.on("change:selectedItem", this.setSelectedComponentInUserProfile.bind(this));
        },

        setSelectedComponentInUserProfile: function () {
            this.State.attributes.actionsStatus = this.ComponentListBox.get("selectedValue");
            this.State.viewModel.setFavoritesInUserProfile();
        },

        regulateDropDowns: function () {
            var $dropDownButtons = $('.sc div[data-sc-id="AutoPersStandardDetailsTabBorder"] .sc-dropdownbutton button');
            $dropDownButtons.on("click", function (e) {
                var $target = $(e.target).closest('.sc-dropdownbutton');
                getTypes(true).forEach(function (type) {
                    var vm = this[type+"DropDown"].viewModel;
                    !vm.$el.is($target) && vm.close();
                }.bind(this));
            }.bind(this));
        },

        populateLists: function () {
            var segments = this.getTimeSegments(23, false);
            this.TrafficListBox.set("items", segments);
            this.AverageTevListBox.set("items", segments);

            var weeks = this.getTimeSegments(7, true);
            this.AverageTevByPageListBox.set("items", weeks);
            this.BounceRateListBox.set("items", weeks);

            function shorten() {
                return this.options.length;
            }
            var $border = $('.sc div[data-sc-id="AutoPersStandardDetailsTabBorder"]'); 
            getTypes(true).forEach(function (type) {
                this[type +"DropDown"].set("isEnabled", true);
                $border.find('select[data-sc-id="'+type+'ListBox"]').attr("size", shorten);
            }.bind(this));
        },

        setListBoxSelectedItems: function () {
            getTypes().forEach(function (type) {
                var listBoxId = type + "ListBox";
                this[listBoxId].set("selectedValue", this[listBoxId].attributes.items[0].value);
            }.bind(this));

            var initialId = this.State.attributes.actionsStatus;
            if (this.ComponentListBox.attributes.items.filter(function (item) {
                return item.id == initialId;
            }).length) {
                this.ComponentListBox.set("selectedValue", initialId);
                return;
            }

            var startIndex = this.ComponentListBox.attributes.items[0].id == "sc-optGroupUnselectable" ? 1 : 0;
            this.ComponentListBox.set("selectedValue", this.ComponentListBox.attributes.items[startIndex].id);
        },

        getTimeSegments: function (days, syncToNaturalWeek) {
            var segments = [];
            var t = moment().subtract(90, 'days').startOf('day');
            if (syncToNaturalWeek) {
                t = t.startOf('week').add(1, 'week');
            }

            while (t.isBefore()) {
                segments.push({ start: t.clone() });
                t.add(days, 'days');
            }

            for (var i = 0; i < segments.length; i++) {
                var seg = segments[i];
                seg.end = i == segments.length - 1 ? moment().clone() : segments[i + 1].start.clone().subtract(1, "days");
                var format = "YYYY-MM-DD";
                seg.value = JSON.stringify({
                    start: seg.start.format(format),
                    end: seg.end.format(format)
                });
                seg.range = getFormattedDate(seg.start.toDate()) + " - " + getFormattedDate(seg.end.toDate());

            }
            return segments.reverse();
        },

        reparentProgressIndicators: function () {
            getTypes().forEach(function (type) {
                $('[data-sc-id="'+type+'Border"]').append($('[data-sc-id="'+type+'ProgressIndicator"]'));
            }.bind(this));
        },

        loadChart: function (chart) {
            if (chart == "AverageTevByPage" || chart == "Component") {
                this.getData("AverageTevByPage", this.AverageTevByPageListBox.get("selectedValue"), this.ComponentListBox.get("selectedValue"));
                this.AverageTevByPageDropDown.viewModel.close();
                this.ComponentDropDown.viewModel.close();
                return;
            }

            this.getData(chart, this[chart+"ListBox"].get("selectedValue"));
            this[chart + "DropDown"].viewModel.close();
            this.ComponentDropDown.viewModel.close();
        },

        getData: function (query, range, componentId, targetComponentId, dataProviderId) {
            if (!targetComponentId) {
                targetComponentId = query + "Chart";
                dataProviderId = query + "ChartDataProvider";
            }

            var parameters = {};
            if (query) {
                parameters.type = query;
            };
            if (range) {
                range = JSON.parse(range);
                            parameters.start = range.start;
                            parameters.end = range.end;
            };

            if (componentId) {
                parameters.componentid = componentId;
            };

            var requestOptions = {
                url: this[dataProviderId].get("dataUrl") + '?' + $.param(parameters),
                onSuccess: function (data) {
                    this.setData(data, targetComponentId);
                }.bind(this),
                onFailure: function () {
                    console.log("Ajax request failure");
                    this.AutoPersStandardMessageBar.addMessage("error", { text: "The server is not responding", actions: [], closable: true })
                },
            }
            this[dataProviderId].viewModel.getData(requestOptions);
        },

        setData: function (data, id) {
            if (data.length && data[0] && data[0].message) {
                var message = data[0].message;
                this.AutoPersStandardMessageBar.addMessage(message.type, { text: message.text, actions: [], closable: true })
                data.shift();
            }
            if (id === "ComponentListBox") {
                if (data && !data.length) {
                    getTypes().forEach(function (type) {
                        this[type + "Chart"].set("dynamicData", []);
                    }.bind(this));
                    return;
                }

                this.populateComponentListBox(data);
            } else if (id === "AutoPersStandardMessageBar" && data) {
                this.AutoPersStandardMessageBar.addMessage("warning", { text: data, actions: [], closable: true })
            } else {
                data = this.convertDates(data);
                if (data && data[0] && data[0].values) {
                    var cumul = data[0].values.reduce(function (a, b) {
                        return a + b.y;
                    }, 0);

                    this[id].viewModel.$el.toggleClass("sc-chart-hide-negatives", !cumul);
                }
                this[id].set("dynamicData", data);
            }
        },

        populateComponentListBox: function (data) {
            var flat = [];
            for (var i = 0; i < data.length; i++) {
                var obj = data[i];
                var list = obj.list;
                if(data.length > 1){
                    flat.push({
                        id: "sc-optGroupUnselectable",
                        label: obj.group
                    });
                }

                for (var j = 0; j < list.length; j++) {
                    var listItem = list[j];
                    var opt = {
                        id: listItem.id,
                        label: listItem.page + " | " + listItem.componentDatasource
                    }
                    flat.push(opt);
                }
            }
            this.ComponentListBox.set("items", flat);
            if (data.length > 1) {
                this.ComponentListBox.viewModel.$el.addClass('sc-indentable-optgroups');
            } else {
                this.ComponentListBox.viewModel.$el.attr("multiple", "multiple");
            }
            this.ComponentListBox.viewModel.$el.find('option').hover(function (e) {
                var $target = $(e.target);
                $target.attr('title', $target[0].innerText);
            });
        },
    
        convertDates: function (data) {
            if (!data) {
                return;
            }
            data.forEach(function (series) {
                series.values.map(function (datum) {
                    datum.date && (datum.date = new Date(datum.date));
                    return datum;
                })
            });
            return data;
        },
    });

    return AutoPersonalizationStandard;
});