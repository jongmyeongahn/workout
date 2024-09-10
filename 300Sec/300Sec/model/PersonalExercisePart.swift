//
//  File.swift
//  300Sec
//
//  Created by arthur on 8/24/24.
//

import Foundation

enum ExercisePart: String, CaseIterable {
    case pushing = "Pushing"     // 밀기 운동
    case pulling = "Pulling"     // 당기기 운동
    case cardio = "Cardio"       // 유산소 운동
    case hold = "Hold"
}

enum Exercise: String {
    // 밀기 운동
    case pushUp = "Push-up"
    case dips = "Dips"
    case pikePushUp = "Pike Push-up"
    case handStandPushup = "Hand Stand Push-Up"
    case handStandWalk = "Hand Stand Walk"
    case airsquat = "Air Squats"
    case pistolSquat = "Pistol Squats L/R"
    case bulgarianSplitSquat = "Bulgarian Split Squat"
    case lunge = "Lunge L/R"
    case sideLunge = "Side-Lunge L/R"
    case walkingLunge = "Walking Lunge"
    case jumpingSquats = "Jumping Squats"
    // 당기기 운동
    case pullUp = "Pull-up"
    case hollowRock = "Hollow Rock"
    case archUp = "Arch Up"
    case archRock = "Arch Rock"
    case situp = "Sit Up"
    case crunch = "Crunch"
    case hipBridge = "Hip Bridge"
    case toetouches = "Toe-Touches"
    case legRaise = "Leg Raise"
    // 유산소 운동
    case jumpingJack = "Jumping Jack"
    case burpee = "Burpee"
    case shuttlerun = "Shuttle Run"
    case dobleUnder = "Double Under"
    case highknee = "High Knee L/R"
    case mountainClimber = "Mountain Climber L/R"
    case barFacingBurpee = "Bar Facing Burpee"
    case bupeeBarTouch = "Bar Burpee Touch"
    case stepUp = "Step-Up"
    case boxJump = "Box Jumps"
    case standingLongJump = "Standing Long Jump"
    // hold 운동
    case plank = "plank"
    case squatHold = "Squat Hold"
    case legRaiseHold = "legRaiseHold"
}

struct ExerciseItem {
    let part: ExercisePart
    let exercise: Exercise
    let count: Int
}

struct ExerciseModel {
    static func getRandomWorkout(includeHold: Bool = false) -> [ExerciseItem] {
//        let parts = ExercisePart.allCases
        let parts: [ExercisePart] = includeHold ? ExercisePart.allCases : ExercisePart.allCases.filter { $0 != .hold }
        
        var exerciseItems: [ExerciseItem] = []
        
        // 랜덤으로 선택할 수 있는 카운트 값 목록
        let possibleCounts = [10, 15, 20]
        
        for part in parts {
            let exercises = exercisesForPart(part: part)
            // 각 운동 종목에서 1개의 운동을 랜덤으로 선택
            if let selectedExercise = exercises.randomElement() {
                let count = possibleCounts.randomElement()!
                exerciseItems.append(ExerciseItem(part: part, exercise: selectedExercise, count: count))
            }
        }
        
        return exerciseItems
    }
    
    private static func exercisesForPart(part: ExercisePart) -> [Exercise] {
        switch part {
        case .pushing:
            return [.pushUp, .dips, .pikePushUp, .handStandPushup, .airsquat, .handStandWalk, .bulgarianSplitSquat, .lunge, .sideLunge, .walkingLunge, .jumpingSquats]
        case .pulling:
            return [.pullUp, .hollowRock, .archUp, .archRock, .situp, .crunch, .hipBridge, .toetouches, .legRaise]
        case .cardio:
            return [.jumpingJack, .burpee, .shuttlerun, .dobleUnder, .highknee, .mountainClimber, .barFacingBurpee, .bupeeBarTouch, .stepUp, .boxJump, .standingLongJump]
        case .hold:
            return [ .plank, .squatHold, .legRaiseHold]
        }
    }
}
