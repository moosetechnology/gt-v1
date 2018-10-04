Class {
	#name : #BaselineOfGTEventRecorder,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTEventRecorder
}

{ #category : #baselines }
BaselineOfGTEventRecorder >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec project: 'Ston' with: [
			spec
				className: #ConfigurationOfSton;
				versionString: #'stable';
				repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'GT-EventRecorder' with: [
				spec requires: #('Ston'). ];
			package: 'GT-EventRecorder-Tests' with: [
				spec requires: #(#'GT-EventRecorder' ) ] ]
]
