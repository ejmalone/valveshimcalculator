// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import NewValveAdjustmentController from "./new_valve_adjustment_controller.js"
application.register("new-valve-adjustment", NewValveAdjustmentController)

import ShimController from "./shim_controller.js"
application.register("shim", ShimController)

import ValveGapsController from "./valve_gaps_controller.js"
application.register("valve-gaps", ValveGapsController)
