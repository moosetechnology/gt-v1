Class {
	#name : #CompanyEmployeeExample,
	#superclass : #Object,
	#instVars : [
		'e',
		'e2',
		'c'
	],
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'as yet unclassified' }
CompanyEmployeeExample >> doMore1: company [
	<gtExample>
	<dependsOn: #employee:company:>
	
	self assert: company == c.
	self assert: company last == e.
	self assert: company size = 2.
	self assert: c size = 2.
	self assert: e size = 1.
	
	e add: #modified.
	c add: #modified.
	
	self assert: company == c.
	self assert: company second == e.
	self assert: company size = 3.
	self assert: c size = 3.
	self assert: e size = 2.
	self assert: company second == c second.
	self assert: e last = #modified.
	self assert: company last = #modified.
	
	^ company
]

{ #category : #'as yet unclassified' }
CompanyEmployeeExample >> doMore2: company employee: employee [
	<gtExample>
	<dependsOn: #doMore1:>
	<dependsOnClass: #EmployeeExample selector: #e>
	
	self assert: company size = 3.
	self assert: company == c.
	self assert: company second == e.
	self assert: (e == employee) not.
	self assert: (e includes: employee) not.
	
	e2 := employee.
	
	^ company
]

{ #category : #'as yet unclassified' }
CompanyEmployeeExample >> doMore3: company1 company: company2 employee: employee [
	<gtExample>
	<dependsOn: #doMore2:employee:>
	<dependsOnClass: #CompanyExample selector: #c>
	<dependsOnClass: #EmployeeExample selector: #e>
	
	self assert: company1 == c.
	self assert: (company2 == c) not.
	self assert: (company1 == company2) not.
	self assert: (employee == e) not.
	self assert: (employee == e2) not.
	self assert: (c includes: employee) not.
]

{ #category : #'as yet unclassified' }
CompanyEmployeeExample >> employee: employee company: company [
	<gtExample>
	<dependsOnClass: #EmployeeExample selector: #e>
	<dependsOnClass: #CompanyExample selector: #c>
	
	self assert: e isNil.
	self assert: c isNil.
	
	e := employee.
	c := company.
	
	self assert: e == employee.
	self assert: c == company.
	
	c add: e.
	
	self assert: (c includes: e).
	
	^ c
]
