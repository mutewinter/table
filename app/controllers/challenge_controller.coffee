App.ChallengeController = Ember.ArrayController.extend
  needs: ['person', 'game']
  game: Ember.computed.alias('controllers.game')
  declineChallenge: (challenge) ->
    
    awayPerson = challenge.get('away')
    awayPerson.get('challenges').removeObject challenge
    awayPerson.save()

    challenge.setProperties
      declined: true

    challenge.save()

    homePerson = challenge.get('home')
    homePerson.get('responses').addObject challenge
    homePerson.save()
  removeResponse: (challenge) ->
    homePerson = challenge.get('home')
    homePerson.get('responses').removeObject challenge
    homePerson.save()
    challenge.delete()
  createChallenge: (homePerson, awayPerson) ->
    challenge = @get('store').createRecord('challenge',
      home: homePerson
      away: awayPerson
      created_at: new Date()
    )
    challenge.save().then (challenge) =>
      awayPerson.get('challenges').addObject challenge
      awayPerson.save()
  acceptChallenge: (challenge) ->
    home = challenge.get('home')
    away = challenge.get('away')
    
    @get('game').addGame(home, away)
    
    away.get('challenges').removeObject challenge
    away.save()
    
    challenge.delete()