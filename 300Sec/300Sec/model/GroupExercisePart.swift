//
//  GroupExercisePart.swift
//  300Sec
//
//  Created by arthur on 8/25/24.
//

import Foundation

enum GroupExercisePart: String, CaseIterable {
    case exercise = "Exercise"     // 움직이는 운동
    case hold = "Hold"     // 멈쳐있는 운동
}

enum GroupExercise: String {
    // 움직이는 운동
    case pushUp = "Push-up"
    case dips = "Dips"
    case pikePushUp = "Pike Push-up"
    case airsquat = "Air Squats"
    case lunge = "Lunge L/R"
    case sideLunge = "Side-Lunge L/R"
    case walkingLunge = "Walking Lunge"
    case jumpingSquats = "Jumping Squats"
    case bulgarianSplitSquat = "Bulgarian Split Squat"
    // hold 운동
    case plank = "plank"
    case squatHold = "Squat Hold"
    case legRaiseHold = "legRaiseHold"

}

struct GroupExerciseItem {
    let part: GroupExercisePart
    let exercise: GroupExercise
    let count: Int?
    
    
    
    func toExerciseItem() -> ExerciseItem {
        let exercise = Exercise(rawValue: exercise.rawValue)
        print("Converted exercise: \(String(describing: exercise))")
        return ExerciseItem(
            part: part == .exercise ? .pushing : .cardio,
            exercise: exercise ?? .pushUp, // 기본값으로 Push-up 설정
            count: part == .hold ? 0 : (count ?? 0)
        )
    }

}

struct GroupsExerciseItem {
    let exercise: GroupExercise
    let count: Int
}

struct GroupExerciseModel {
    static func getRandomWorkout() -> [GroupExerciseItem] {
        let parts = GroupExercisePart.allCases
        
        var exerciseItems: [GroupExerciseItem] = []
        
        // 랜덤으로 선택할 수 있는 카운트 값 목록
        let possibleCounts = [5, 10, 15, 20]
        
        for part in parts {
            let exercises = exercisesForPart(part: part)
            if let selectedExercise = exercises.randomElement() {
                let count = part == .exercise ? possibleCounts.randomElement() : nil
                exerciseItems.append(GroupExerciseItem(part: part, exercise: selectedExercise, count: count))
            }
        }
        
        return exerciseItems
    }
    
    private static func exercisesForPart(part: GroupExercisePart) -> [GroupExercise] {
        switch part {
        case .exercise:
            return [.pushUp, .dips, .pikePushUp, .airsquat, .bulgarianSplitSquat, .lunge, .sideLunge, .walkingLunge, .jumpingSquats]
        case .hold:
            return [.plank, .squatHold, .legRaiseHold]
        }
    }
}
