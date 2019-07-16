//
//  TBApiProvider.swift
//  TheBod
//
//  Created by YYang1 on 19/11/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import Foundation


//enum TBApi{
//    //login{
//    case createAccount(firstName: String, lastName: String, email: String, userName: String, password: String)
//    case login(email: String, password: String)
//    case forgotPassword(email: String)
//    case facebookLogin(token: String)
//    case deviceToken(token: String, deviceType: String?, deviceModel: String?, OSVserion: String?, appVersion: String?)
//    case removeDeviceToken(token: String)
//    case validateEmail(firstName: String, lastName: String, email: String)
//    //}
//    //Newsfeed{
//    case getNewsFeeds(page: Int)
//    case getQuestion(questionId: String)
//    case updateQuestion(questionId: String, answerId: String)
//    case getResartPasses(page: Int)
//    case activePass(restartPassId: Int)
//    case showPass(restartPassId: Int)
//    case showWeekImage(userRestartPassWeekId: Int)
//    case updateWeekImage(weekId: Int, currentWeight: String?, picId: Int?, picAspect: PictureAspect?, image: UIImage?, destory: String?)
//    //}
//    //Workout{
//    case getWorkoutsCategories
//    case getWorkoutsCategoryList(type: String, page: Int)
//    case getExercises(workId: Int, cotentItemId: Int?)
//    case exerciseDetails(workoutId: Int?, exerciseId: Int?, alernativeForExercisesId: Int?, workoutContentItemId: Int?, cotentItemId: Int?, workoutExercisesId: Int?)
//    case getGlossaryList(page: Int)
//    case completeWorkout(workoutId: Int, completed: Bool, cotentItemId: Int, location: ExerciseLocation?)
//    case completeExercise(exerciseId: Int, completed: Bool, cotentItemId: Int?, location: ExerciseLocation?, workoutId: Int?, detail: Bool?, workoutExercisesId: Int?, workoutContentItemId: Int?, personalBest: String?)
//    case resetLevel(category: WeekPlanCatgory, location: ExerciseLocation?, option: MealPlanOption?, level: String, weekPlanId: String?)
//    case postRestPersonalBest(exerciseId: Int?)
//    //}
//    //Nutrition{
//    case getRecipes(page: Int)
//    case getRecipeDetail(recipeId: Int?, contentItemId: Int?, personalContentItemId: Int?)
//    case updateRecipe(recipeId: Int, contentItemId: Int?, personalContentItemId: Int?, complete: Bool)
//    case getNutritionCategories
//    case getGroceriesList(page: Int)
//    case clearGroceries
//    case exportGroceries
//    case updateGrocery(ingredientId: String?, completed: Bool?, action: GrocerySelectAction?)
//    case ingredientComplete(recipeIngredientId: Int?, ingredientId: Int?, targetId: Int?, targetType: String?)
//    case addToGroceries(recipeId: Int?, contentItemId: Int?, targetId: Int?, targetType: String?)
//    case addToDieting(recipeId: Int?, contentItemId: Int?, personalContentItemId: Int?)
//    case getWorkoutWeekPlan(category: WeekPlanCatgory, location: ExerciseLocation?, option: MealPlanOption?, level: String?, week: String?, day: String?, weekPlanId: String?)
//    case getNutritionWeekPlan(category: WeekPlanCatgory, location: ExerciseLocation?, option: MealPlanOption?, level: String?, week: String?, day: String?, weekPlanId: String?)
//    case mealPlanComplete(weekPlanId: String)
//    case mealPlanReset(weekPlanId: String)
//    case getIngredient(ingredientId: Int, quantity: Float)
//    case updateIngredient(ingredientId: Int, contentItemId: Int?, personalContentItemId: Int?, complete: Bool)
//    case addIngredientToDieting(title: String, carbs: String, protein: String, fats: String, fibre: String, sugar: String, quantity: String, weekPlanId: Int, ingredientId: Int?)
//    case destoryIngredient(ingredientId: Int?)
//    case mealPalnDuplicate(contentItemId: Int, eatAs: String)
//    case mealPlanMotion(weekPlanId: Int, sourceKey: String, targetKey: String, sourceIds: [[String: Int]], targetIds: [[String: Int]])
//    //}
//    //Profile/Setting
////    {
//    case updateUser(userInfo: [String: Any])
//    case userInfo
//    case getLevel
//    case getWeek
//    case getDay
//    case changeProgram(level: String?, week: String?, day: String?)
//    case myCollections(category: CollectionCategory?)
//    case showCollection(id: Int)
//    case getOneRms
//    case updateOneRms(rmParams:OneRmParams)
//    case getMyProgressList(page: Int)
//    case updateMyProgressImage(weekNumber: Int?, picId: Int?, picAspect: PictureAspect?, image: UIImage?, destory: String?)
//    case getDefinitions(page: Int)
//    case getFaqs(page: Int)
//    //}
//    // Store
////    {
//    case getProductsList
//    case globalSearch(page: Int, keyword: String, searchType: String?)
//    case uploadRecipt(data: String, type: String?)
//
////     }
//
//}
//
//
//extension TBApi: TargetType {
//    var path: String {
//        switch self {
//        case .createAccount:
//            return "v1/users/email/signup"
//        case .login:
//            return "v1/users/email/login"
//        case .forgotPassword:
//            return "v1/users/forget-password"
//        case .getNewsFeeds:
//            return "v1/news_feeds"
//        case .facebookLogin:
//            return "v1/users/facebook/login"
//        case .updateUser, .userInfo:
//            return "v1/users/user"
//        case .getLevel:
//            return "v1/levels"
//        case .getWeek:
//            return "v1/weeks"
//        case .getDay:
//            return "v1/days"
//        case .changeProgram:
//            return "v1/program/reset"
//        case .getRecipes:
//            return "v1/user/recipes"
//        case .getRecipeDetail:
//            return "v1/user/recipe"
//        case .getWorkoutsCategoryList:
//            return "v1/user/workouts"
//        case .getWorkoutsCategories:
//            return "v1/workouts_list"
//        case .getNutritionCategories:
//            return "v1/meal_plans_list"
//        case .getExercises:
//            return "v1/user/workout"
//        case .exerciseDetails:
//            return "v1/user/exercise"
//        case .getGroceriesList:
//            return "v1/user/groceries"
//        case .clearGroceries:
//            return "v1/user/grocery"
//        case .updateGrocery:
//            return "v1/user/grocery"
//        case .getQuestion:
//            return "v1/user/question"
//        case .updateQuestion:
//            return "v1/user/question"
//        case .addToGroceries:
//            return "v1/user/add_ingredients"
//        case .addToDieting:
//            return "v1/user/recipe/add_flexible_dieting"
//        case .myCollections:
//            return "v1/user/collections"
//        case .getGlossaryList:
//            return "v1/user/glossary"
//        case .exportGroceries:
//            return "v1/user/groceries/export"
//        case .getOneRms:
//            return "v1/users/one-rms"
//        case .updateOneRms:
//            return "v1/users/one-rms"
//        case .getProductsList:
//            return "v1/shopping_list"
//        case .globalSearch:
//            return "v1/search"
//        case .getWorkoutWeekPlan:
//            return "v1/user/workout_week_plans"
//        case .getNutritionWeekPlan:
//            return "v1/user/nutrition_week_plans"
//        case .mealPlanComplete:
//            return "v1/user/week_plans/complete"
//        case .mealPlanReset:
//            return "v1/user/week_plans/reset"
//        case .uploadRecipt:
//            return "v1/ios_receipts"
//        case .showCollection:
//            return "v1/user/collection"
//        case .updateRecipe:
//            return "v1/user/recipe"
//        case .updateIngredient:
//            return "v1/user/ingredient"
//        case .getResartPasses:
//            return "v1/user/restart_passes"
//        case .activePass:
//            return "v1/user/active_restart_pass"
//        case .showPass:
//            return "v1/user/restart_pass"
//        case .getMyProgressList:
//            return "v1/user/my_progress/weeks"
//        case .showWeekImage:
//            return "v1/user/restart_pass_week"
//        case .completeWorkout:
//            return "v1/user/workout"
//        case .completeExercise:
//            return "v1/user/exercise"
//        case .getIngredient:
//            return "v1/user/ingredient"
//        case .addIngredientToDieting:
//            return "v1/user_contributed_ingredients"
//        case .ingredientComplete:
//            return "v1/user/ingredient/complete"
//        case .destoryIngredient(let id):
//            return "v1/user_contributed_ingredients/\(id!)"
//        case .mealPalnDuplicate:
//            return "v1/user/week_plans/duplicate"
//        case .mealPlanMotion:
//            return "v1/user/week_plans/order_item"
//        case .deviceToken:
//            return "v1/user/devices"
//        case .removeDeviceToken:
//            return "v1/user/devices"
//        case .updateWeekImage:
//            return "v2/user/restart_pass_week"
//        case .resetLevel:
//            return "v1/user/week_plans/reset_level"
//        case .getDefinitions:
//            return "v1/definitions"
//        case .getFaqs:
//            return "v1/faqs"
//        case .validateEmail:
//            return "v1/users/email/validate"
//        case .updateMyProgressImage:
//            return "v1/user/my_progress/week"
//        case .postRestPersonalBest:
//            return "v1/user/exercise/reset"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .createAccount, .login, .facebookLogin, .addToGroceries, .addToDieting, .mealPlanComplete, .mealPlanReset, .uploadRecipt, .activePass, .addIngredientToDieting, .mealPalnDuplicate, .mealPlanMotion, .deviceToken, .resetLevel, .ingredientComplete, .validateEmail, .postRestPersonalBest:
//            return .post
//        case .forgotPassword, .getNewsFeeds, .userInfo, .getLevel, .getDay, .getWeek, .getWorkoutsCategoryList, .getRecipes, .getWorkoutsCategories, .getNutritionCategories, .getExercises, .exerciseDetails, .getGroceriesList, .getRecipeDetail, .getQuestion, .myCollections, .getGlossaryList, .exportGroceries, .getOneRms, .getProductsList, .globalSearch, .getWorkoutWeekPlan, .getNutritionWeekPlan, .showCollection, .getResartPasses, .showPass, .getMyProgressList, .showWeekImage, .getIngredient, .getDefinitions, .getFaqs:
//            return .get
//        case .updateUser, .changeProgram, .updateGrocery, .updateQuestion, .updateOneRms, .updateRecipe, .updateIngredient, .completeWorkout, .completeExercise, .updateWeekImage, .updateMyProgressImage:
//            return .put
//        case .clearGroceries, .removeDeviceToken, .destoryIngredient:
//            return .delete
//        }
//    }
//
//    var parameters: [String: Any]? {
//        var params = [String: Any]()
//        switch self {
//        case .userInfo, .getLevel, .getWeek, .getDay, .getWorkoutsCategories, .getNutritionCategories, .clearGroceries, .exportGroceries, .getOneRms, .getProductsList, .updateWeekImage, .destoryIngredient, .updateMyProgressImage:
//            return nil
//        case .createAccount(let fName, let lName, let email, let userName, let pwd):
//            return ["user":["first_name": fName, "last_name": lName, "email": email, "username": userName, "password":pwd]]
//        case .login(let email, let pwd):
//            return ["email": email, "password": pwd]
//        case .facebookLogin(let token):
//            return ["facebook_token": token]
//        case .forgotPassword(let email):
//            return ["email": email]
//        case .updateUser(let userDict):
//            return ["user":userDict]
//        case .changeProgram(let level, let week, let day):
//            params["level"] = level
//            params["week"] = week
//            params["day"] = day
//            return params
//        case .getWorkoutsCategoryList(let type, let page):
//            params["exercise_type"] = type
//            params["page"] = "\(page)"
//            return params
//        case .getExercises(let workoutId, let contentItemId):
//            params["workout_id"] = workoutId
//            params["content_item_id"] = contentItemId
//            return params
//        case .exerciseDetails(let workoutId, let exerciseId, let alernativeForExercisesId, let workoutContentItemId, let cotentItemId, let workoutExercisesId):
//            params["exercise_id"]  = exerciseId
//            params["alternative_for_exercise"]  = alernativeForExercisesId
//            params["workout_content_item_id"]  = workoutContentItemId
//            params["content_item_id"]  = cotentItemId
//            params["workout_id"]  = workoutId
//            params["workout_exercise_id"]  = workoutExercisesId
//            return params
//        case .getGroceriesList(let page):
//            params["page"] = "\(page)"
//            return params
//        case .updateGrocery(let ingredientId, let completed, let action):
//            params["completed"] = completed
//            params["ingredient_id"] = ingredientId
//            params["grocery_select_action"] = action?.rawValue
//            return params
//        case .getRecipeDetail(let recipeId, let contentItemId, let personalContentItemId):
//            params["recipe_id"] = recipeId
//            params["content_item_id"] = contentItemId
//            params["personal_content_item_id"] = personalContentItemId
//            return params
//        case .getQuestion(let qId):
//            params["question_id"] = qId
//            return params
//        case .updateQuestion(let questionId, let answerId):
//            params["question_id"] = questionId
//            params["answer_id"] = answerId
//            params["user_id"] = "\(UserDefaults.UserInfo.integer(forKey: .userId))"
//            let dict = ["user_question_answer": params]
//            return dict
//        case .getRecipes(let page):
//            params["page"] = "\(page)"
//            return params
//        case .ingredientComplete(let recipeIngredientId, let ingredientId, let targetId, let targetType):
//            params["recipe_ingredient_id"] = recipeIngredientId
//            params["ingredient_id"] = ingredientId
//            params["target_id"] = targetId
//            params["target_type"] = targetType
//            return params
//        case .addToGroceries( let recipeId ,let contentItemId, let targetId, let targetType):
//            params["recipe_id"] = recipeId
//            params["content_item_id"] = contentItemId
//            params["target_id"] = targetId
//            params["target_type"] = targetType
//            return params
//        case .addToDieting(let recipeId, let contentItemId, let personalContentItemId):
//                params["recipe_id"] = recipeId
//                params["content_item_id"] = contentItemId
//                params["personal_content_item_id"] = personalContentItemId
//            return params
//        case .getGlossaryList(let page):
//            params["page"] = "\(page)"
//            return params
//        case .getNewsFeeds(let page):
//            params["page"] = "\(page)"
//            return params
//        case .globalSearch(let page, let keyword, let type):
//            var dict = [String: Any]()
//            dict["key_words"] = keyword
//            dict["search_type"] = type
//            params["page"] = "\(page)"
//            params["global_search"] = dict
//            return params
//        case .getWorkoutWeekPlan(let category, let location, let option, let level, let week, let day, let weekPlanId):
//            params["category"] = category.rawValue
//            params["level"] = level
//            params["week"] = week
//            params["day"] = day
//            params["meal_plan_option"] = option?.rawValue
//            params["exercise_location"] = location?.rawValue
//            params["week_plan_id"] = weekPlanId
//            return params
//        case .getNutritionWeekPlan(let category, let location, let option, let level, let week, let day, let weekPlanId):
//            params["category"] = category.rawValue
//            params["level"] = level
//            params["week"] = week
//            params["day"] = day
//            params["meal_plan_option"] = option?.rawValue
//            params["exercise_location"] = location?.rawValue
//            params["week_plan_id"] = weekPlanId
//            return params
//        case .resetLevel(let category, let location, let option, let level, let weekPlanId):
//            params["category"] = category.rawValue
//            params["level"] = level
//            params["meal_plan_option"] = option?.rawValue
//            params["exercise_location"] = location?.rawValue
//            params["week_plan_id"] = weekPlanId
//            return params
//        case .mealPlanComplete(let id):
//            params["week_plan_id"] = id
//            return params
//        case .mealPlanReset(let id):
//            params["week_plan_id"] = id
//            return params
//        case .uploadRecipt(let recipt, let type):
//            params["ios_receipt"] = ["data": recipt, "in_app_purchases_item_type": type]
//            return params
//        case .showCollection(let id):
//            params["id"] = "\(id)"
//            return params
//
//        case .updateRecipe(let recipeId, let contentItemId, let personalContentItemId , let complete):
//            var dict = [String: Any]()
//            if let personalContentItemId = personalContentItemId{
//                params["personal_content_item_id"] = "\(personalContentItemId)"
//            }else if let contentItemId = contentItemId{
//                dict["content_item_id"] = "\(contentItemId)"
//            }
//            dict["completed"] = complete
//            dict["recipe_id"] = recipeId
//            params["user_activity"] = dict
//            return params
//        case .updateIngredient(let ingredientId, let contentItemId, let personalContentItemId, let complete):
//            var dict = [String: Any]()
//            if let personalContentItemId = personalContentItemId{
//                params["personal_content_item_id"] = "\(personalContentItemId)"
//            }else if let contentItemId = contentItemId{
//                dict["content_item_id"] = "\(contentItemId)"
//            }
//            dict["completed"] = complete
//            dict["ingredient_id"] = ingredientId
//            params["user_activity"] = dict
//            return params
//        case .getResartPasses(let page):
//            params["page"] = "\(page)"
//            return params
//        case .activePass(let restartPassId):
//            params["restart_pass_id"] = "\(restartPassId)"
//            return params
//        case .showPass(let restartPassId):
//            params["restart_pass_id"] = "\(restartPassId)"
//            return params
//        case .showWeekImage(let weekId):
//            params["user_restart_pass_week_id"] = "\(weekId)"
//            return params
//        case .completeWorkout(let workoutId, let completed, let contentItemId,  let location):
//            var dict = [String: Any]()
//            dict["workout_id"] = "\(workoutId)"
//            dict["completed"] = completed
//            dict["content_item_id"] = "\(contentItemId)"
//            params["user_activity"] = dict
//            params["exercise_location"] = location?.rawValue
//            return params
//        case .completeExercise(let exerciseId, let completed, let contentItemId, let location, let workoutId, let detail, let workoutExercisesId, let workoutContentItemId, let best):
//            var dict = [String: Any]()
//            dict["exercise_id"] = exerciseId
//            dict["completed"] = completed
//            dict["content_item_id"] = contentItemId
//            dict["workout_id"] = workoutId
//            dict["workout_exercise_id"] = workoutExercisesId
//            dict["workout_content_item_id"] = workoutContentItemId
//            params["user_activity"] = dict
//            params["detail"] = detail
//            params["personal_best"] = best
//            params["exercise_location"] = location?.rawValue
//            return params
//        case .getIngredient(let ingredientId, let quantity):
//            params["ingredient_id"] = "\(ingredientId)"
//            params["quantity"] = "\(quantity)"
//            return params
//        case .addIngredientToDieting(let title, let carbs, let protein, let fats, let fibre, let sugar, let quantity, let weekPlanId, let ingredientId):
//            var dict = [String: Any]()
//            dict["title"] = title
//            dict["carbs"] = carbs
//            dict["fats"] = fats
//            dict["fibre"] = fibre
//            dict["sugar"] = sugar
//            dict["quantity"] = quantity
//            dict["protein"] = protein
//            params["user_contributed_ingredient"] = dict
//            params["week_plan_id"] = weekPlanId
//            params["ingredient_id"] = ingredientId
//            return params
//        case .mealPalnDuplicate(let contentItemId, let eatAs):
//            params["content_item_id"] = contentItemId
//            params["eat_as"] = eatAs
//            return params
//        case .mealPlanMotion(let weekPlanId ,let sourceKey, let targetKey, let sourceIds, let targetIds):
//            var sDict = [String: Any]()
//            var tDict = [String: Any]()
//            sDict[sourceKey] = sourceIds
//            tDict[targetKey] = targetIds
//            params["week_plan_id"] = weekPlanId
//            sDict.merge(tDict){ $1 }
//            params["order"] = sDict
//            return params
//        case .updateOneRms(let rmParams):
//            var rms = [String: [String: String]]()
//            for dict in rmParams{
//                rms.merge(dict){$1}
//            }
//            return rms
//        case .deviceToken(let token, let deviceType, let deviceModel, let OSVserion, let appVersion):
//            var dict = [String: Any]()
//            dict["device_type"] = deviceType
//            dict["device_model"] = deviceModel
//            dict["device_token"] = token
//            dict["device_os_version"] = OSVserion
//            dict["app_version"] = appVersion
//            params["user_device"] = dict
//            return params
//        case .removeDeviceToken(let token):
//            params["device_token"] = token
//            return params
//        case .myCollections(let category):
//            params["category"] = category?.rawValue
//            return params
//        case .getDefinitions(let page):
//            params["page"] = "\(page)"
//            return params
//        case .getFaqs(let page):
//            params["page"] = "\(page)"
//            return params
//        case .validateEmail(let firstName, let lastName, let email):
//            return ["user":["first_name": firstName, "last_name": lastName, "email": email]]
//        case .getMyProgressList(let page):
//            params["page"] = "\(page)"
//            return params
//        case .postRestPersonalBest(let exerciseId):
//            params["exercise_id"] = exerciseId
//            return params
//         }
//
//
//    }
//
//    var task: Task {
//        switch self {
//        case .createAccount, .login, .facebookLogin, .changeProgram, .updateGrocery, .updateQuestion, .addToGroceries, .addToDieting, .updateOneRms, .mealPlanComplete, .mealPlanReset, .uploadRecipt, .updateRecipe, .updateIngredient, .activePass, .completeWorkout, .completeExercise, .addIngredientToDieting, .mealPalnDuplicate, .mealPlanMotion, .deviceToken, .resetLevel, .ingredientComplete, .validateEmail, .postRestPersonalBest:
//            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
//        case .forgotPassword, .getWorkoutsCategoryList, .getExercises, .exerciseDetails, .getGroceriesList, .getRecipes, .getRecipeDetail, .getQuestion, .getGlossaryList, .getNewsFeeds, .globalSearch, .getWorkoutWeekPlan, .getNutritionWeekPlan, .showCollection, .getResartPasses, .showPass, .showWeekImage, .getIngredient, .removeDeviceToken, .myCollections, .getDefinitions, .getFaqs, .getMyProgressList:
//            return .requestParameters(parameters: parameters!, encoding: URLEncoding.methodDependent)
//
//        case .userInfo, .getLevel, .getWeek, .getDay, .getWorkoutsCategories, .getNutritionCategories, .clearGroceries, .exportGroceries, .getOneRms, .getProductsList, .destoryIngredient:
//            return .requestPlain
//
//        case .updateUser(let params):
//            if let avatars = params["avatar"]{
//                var imageDatas = Array<Moya.MultipartFormData>()
//                (avatars as! Array<UIImage>).forEach {
//                    if let data = $0.jpegData(compressionQuality: 0.3){
//                        imageDatas.append(Moya.MultipartFormData(provider: .data(data), name: "user[avatar]",fileName: "avatar.jpg", mimeType: "image/jpeg"))
//                    }
//                }
//                return .uploadMultipart(imageDatas)
//            }else{
//                return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
//            }
//
//        case .updateWeekImage(let weekId, let currentWeight, let picId, let picAspect, let image, let destory):
//            var multiDatas = Array<Moya.MultipartFormData>()
//            if let image = image, let data = image.jpegData(compressionQuality: 0.8){
//                let imageFormData = MultipartFormData(provider: .data(data), name: "user_restart_pass_week[user_week_pictures_attributes[]image]",fileName: "\(String.currentTime()).jpg", mimeType: "image/jpeg")
//                multiDatas.append(imageFormData)
//            }
//
//            if let picAspect = picAspect, let aspectData = picAspect.rawValue.data(using: .utf8){
//                let aspectFormData = MultipartFormData(provider: .data(aspectData), name: "user_restart_pass_week[user_week_pictures_attributes[]taken_direction]")
//                multiDatas.append(aspectFormData)
//            }
//
//            if let weight = currentWeight, let weightData = weight.data(using: .utf8){
//                let weightFormData = MultipartFormData(provider: .data(weightData), name: "user_restart_pass_week[current_weight]")
//                multiDatas.append(weightFormData)
//            }
//
//            if let id = picId, let idData = String(id).data(using: .utf8){
//                let idFormData = MultipartFormData(provider: .data(idData), name: "user_restart_pass_week[user_week_pictures_attributes[]id]")
//                multiDatas.append(idFormData)
//            }
//
//            if let des = destory, let desData = des.data(using: .utf8){
//                let idFormData = MultipartFormData(provider: .data(desData), name: "user_restart_pass_week[user_week_pictures_attributes[]_destroy]")
//                multiDatas.append(idFormData)
//            }
//            let weekIdData =  String(weekId).data(using: .utf8)!
//            let weekIdFormData = MultipartFormData(provider: .data(weekIdData), name: "user_restart_pass_week[id]")
//            multiDatas.append(weekIdFormData)
//            return .uploadMultipart(multiDatas)
//
//        case .updateMyProgressImage(let weekNumber, let picId, let picAspect, let image, let destory):
//            var multiDatas = Array<Moya.MultipartFormData>()
//            if let image = image, let data = image.jpegData(compressionQuality: 0.8){
//                let imageFormData = MultipartFormData(provider: .data(data), name: "progress_week[user_week_pictures_attributes[]image]",fileName: "\(String.currentTime()).jpg", mimeType: "image/jpeg")
//                multiDatas.append(imageFormData)
//            }
//
//            if let picAspect = picAspect, let aspectData = picAspect.rawValue.data(using: .utf8){
//                let aspectFormData = MultipartFormData(provider: .data(aspectData), name: "progress_week[user_week_pictures_attributes[]taken_direction]")
//                multiDatas.append(aspectFormData)
//            }
//
//            if let id = picId, let idData = String(id).data(using: .utf8){
//                let idFormData = MultipartFormData(provider: .data(idData), name: "progress_week[user_week_pictures_attributes[]id]")
//                multiDatas.append(idFormData)
//            }
//
//            if let des = destory, let desData = des.data(using: .utf8){
//                let idFormData = MultipartFormData(provider: .data(desData), name: "progress_week[user_week_pictures_attributes[]_destroy]")
//                multiDatas.append(idFormData)
//            }
//            let weekNumberData =  String(weekNumber!).data(using: .utf8)!
//            let weekNumberFormData = MultipartFormData(provider: .data(weekNumberData), name: "progress_week[number]")
//            multiDatas.append(weekNumberFormData)
//            return .uploadMultipart(multiDatas)
//
//
//        }
//
//
//    }
//
//
//    var headers: [String : String]? {
//        var header = ["Content-type": "application/json"]
//        header["X-AUTH-TOKEN"] = UserDefaults.UserInfo.string(forKey: .accessToken)
//        header["X-USER-ID"] = UserDefaults.UserInfo.string(forKey: .userId)
//        header["X-USER-TIMEZONE"] = TimeZone.current.identifier
//        header["X-APPLE-STORE-COUNTRY"] = UserDefaults.UserInfo.string(forKey: .currentStoreRegion)
//
//        return header
//    }
//
//    var baseURL: URL {
//        return URL(string: (BaseURL + "/api/"))!
//    }
//
//    var sampleData: Data {
//        return Data()
//    }
//
//
//}
//
//protocol TBTargetCustomizableType {
//    var delayHud: Bool { get }
//    var needHud: Bool { get }
//    var interaction: Bool { get }
//}
//
//extension MultiTarget: TBTargetCustomizableType {
//    var delayHud: Bool{
//        switch self {
//        case .target(TBApi.getProductsList):
//            return true
//        default:
//            return false
//        }
//    }
//
//    var needHud: Bool{
//        switch self {
//        case .target(TBApi.forgotPassword), .target(TBApi.getWorkoutsCategories), .target(TBApi.getNutritionCategories):
//        return false
//        default:
//            return true
//        }
//    }
//    var interaction: Bool{
//        switch self {
////        case .target(TBApi.getProductsList), .target(TBApi.uploadRecipt):
////            return false
//        default:
//            return true
//        }
//    }
//
//}
