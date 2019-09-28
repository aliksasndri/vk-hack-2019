//
//  RequestViewController.swift
//  SunCity
//
//  Created by Anton Dryakhlykh on 27/09/2019.
//  Copyright © 2019 Ivan Smetanin. All rights reserved.
//

import UIKit

final class RequestViewController: UIViewController, RequestModuleOutput {

    // MARK: - IBOutlets

    @IBOutlet weak var stackView: UIStackView!

    // MARK: - RequestModuleOutput

    // MARK: - Constants

    let lastNameField = TextField()
    let firstNameField = TextField()
    let middleNameField = TextField()
    let registerAddressField = TextField()
    let factAddressField = TextField()
    let phoneField = TextField()
    let emailField = TextField()
    let faithField = TextField()
    let birthField = TextField()
    let nationalityField = TextField()
    let rateField = TextField()
    let illField = TextField()
    let educationField = TextField()
    let educationOrgField = TextField()
    let degreeField = TextField()
    let jobOrgField = TextField()
    let jobContactsField = TextField()
    let jobPositionField = TextField()
    let jobResponsibilitiesField = TextField()
    let jobTimeField = TextField()
    let hobbieField = TextField()
    let familyStatusField = TextField()
    let partnerNameField = TextField()
    let partnerSexField = TextField()
    let partnerOldField = TextField()
    let relationshipField = TextField()
    let childOrgNameField = TextField()
    let childContactsField = TextField()
    let childPositionField = TextField()
    let childResponsibilitesField = TextField()
    let childOldGroupField = TextField()
    let mentorTypeField = TextField()
    let mentorReasonField = TextField()
    let mentorRecomendationsField = TextField()
    let selfRecomendationsField = TextField()
    let reasonWhyField = TextField()
    let childAgeField = TextField()
    let childSexField = TextField()
    let childTypeField = TextField()
    let visitFrequencyField = TextField()
    let childBrokenField = TextField()
    let alcoholField = TextField()
    let psyField = TextField()
    let cigaretsField = TextField()
    let drugsField = TextField()
    let crimeField = TextField()
    let parentalRightsField = TextField()
    let reportsField = TextField()
    let privacyField = TextField()
    let findField = TextField()

    // MARK: - Properties

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addDropdowns()
    }

    // MARK: - Internal helpers

}

// MARK: - Private helpers

private extension RequestViewController {
    func addDropdowns() {
        addUserInfoDropdown()
        addHealthDropdown()
        addEducationDropdown()
        addJobDropdown()
        addHobbieDropdown()
        addFamilyDropdown()
        addChildExperienceDropdown()
        addOtherDropdown()
        addLawDropdown()
    }

    func addUserInfoDropdown() {
        lastNameField.fill(placeholder: "Фамилия")
        firstNameField.fill(placeholder: "Имя")
        middleNameField.fill(placeholder: "Отчество")
        registerAddressField.fill(placeholder: "Адрес регистрации")
        factAddressField.fill(placeholder: "Адрес фактического проживания")
        phoneField.fill(placeholder: "Контактный телефон")
        emailField.fill(placeholder: "Электронный адрес")
        faithField.fill(placeholder: "Вероисповедание")
        birthField.fill(placeholder: "Дата рождения")
        nationalityField.fill(placeholder: "Гражданство РФ")

        let userInfoView = ExpandableView()
        userInfoView.fill(title: "Общие сведения", textFields: [lastNameField, firstNameField, middleNameField, registerAddressField, factAddressField, phoneField, emailField, faithField, birthField, nationalityField])

        stackView.addArrangedSubview(userInfoView)
    }

    func addHealthDropdown() {
        rateField.fill(placeholder: "Оцените состояние здоровья")
        illField.fill(placeholder: "Укажите серьезные заболевания")

        let healthView = ExpandableView()
        healthView.fill(title: "Состояние здоровья", textFields: [rateField, illField])

        stackView.addArrangedSubview(healthView)
    }

    func addEducationDropdown() {
        educationField.fill(placeholder: "Образование")
        educationOrgField.fill(placeholder: "Учебное заведение")
        degreeField.fill(placeholder: "Полученная специальность")

        let educationView = ExpandableView()
        educationView.fill(title: "Образование", textFields: [educationField, educationOrgField, degreeField])

        stackView.addArrangedSubview(educationView)
    }

    func addJobDropdown() {
        jobOrgField.fill(placeholder: "Название организации")
        jobContactsField.fill(placeholder: "Контактная информация ")
        jobPositionField.fill(placeholder: "Должность")
        jobResponsibilitiesField.fill(placeholder: "Исполняемые обязанности")
        jobTimeField.fill(placeholder: "График работы")

        let jobView = ExpandableView()
        jobView.fill(title: "Трудоустройство", textFields: [jobOrgField, jobContactsField, jobPositionField, jobResponsibilitiesField, jobTimeField])

        stackView.addArrangedSubview(jobView)
    }

    func addHobbieDropdown() {
        hobbieField.fill(placeholder: "Чем занимаетесь в свободное время?")

        let hobbieView = ExpandableView()
        hobbieView.fill(title: "Интересы, хобби", textFields: [hobbieField])

        stackView.addArrangedSubview(hobbieView)
    }

    func addFamilyDropdown() {
        familyStatusField.fill(placeholder: "Семейное положение")
        partnerNameField.fill(placeholder: "Имя")
        partnerSexField.fill(placeholder: "Пол")
        partnerOldField.fill(placeholder: "Возраст")
        relationshipField.fill(placeholder: "Кем приходится?")

        let familyView = ExpandableView()
        familyView.fill(title: "Семейное положение", textFields: [familyStatusField, partnerNameField, partnerSexField, partnerOldField, relationshipField])

        stackView.addArrangedSubview(familyView)
    }

    func addChildExperienceDropdown() {
        childOrgNameField.fill(placeholder: "Название организации")
        childContactsField.fill(placeholder: "Контактная информация")
        childPositionField.fill(placeholder: "Должность")
        childResponsibilitesField.fill(placeholder: "Исполняемые обязанности")
        childOldGroupField.fill(placeholder: "Возрастная группа детей")

        let childView = ExpandableView()
        childView.fill(title: " Опыт работы с детьми", textFields: [childOrgNameField, childContactsField, childPositionField, childResponsibilitesField, childOldGroupField])

        stackView.addArrangedSubview(childView)
    }

    func addOtherDropdown() {
        mentorTypeField.fill(placeholder: "Ваша роль в наставничестве?")
        mentorReasonField.fill(placeholder: "Почему вы хотите выполнять эту роль?")
        mentorRecomendationsField.fill(placeholder: "Как вы можете помочь ребенку?")
        selfRecomendationsField.fill(placeholder: "Опишите себя")
        reasonWhyField.fill(placeholder: "Почему хотите помогать?")
        childAgeField.fill(placeholder: "Возраст ребенка?")
        childSexField.fill(placeholder: "Пол ребенка")
        childTypeField.fill(placeholder: "Характер ребенка?")
        visitFrequencyField.fill(placeholder: "Частота посещения")
        childBrokenField.fill(placeholder: "Согласны работать с ребенком с ограничениями?")

        let otherView = ExpandableView()
        otherView.fill(title: "Другие вопросы", textFields: [mentorTypeField, mentorReasonField, mentorRecomendationsField, selfRecomendationsField, reasonWhyField, childAgeField, childSexField, childTypeField, visitFrequencyField, childBrokenField])

        stackView.addArrangedSubview(otherView)
    }

    func addLawDropdown() {
        alcoholField.fill(placeholder: "Употребляете ли вы алкоголь?")
        psyField.fill(placeholder: "Употребляете ли вы табачные изделия?")
        cigaretsField.fill(placeholder: "Употребляете ли вы психотропные вещества?")
        drugsField.fill(placeholder: "Употребляли ли вы наркотики?")
        crimeField.fill(placeholder: "Были ли вы осуждены?")
        parentalRightsField.fill(placeholder: "Были ли вы лишены родительских прав?")
        reportsField.fill(placeholder: "Согласны заполнять отчеты по работе?")
        privacyField.fill(placeholder: "Разрешаете использовать ваши данные?")
        findField.fill(placeholder: "Откуда узнали о программе?")

        let lawView = ExpandableView()
        lawView.fill(title: "Нарушения закона", textFields: [alcoholField, psyField, cigaretsField, drugsField, crimeField, parentalRightsField, reportsField, privacyField, findField])

        stackView.addArrangedSubview(lawView)
    }
}
