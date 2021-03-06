App.Person = FP.Model.extend
  name: FP.attr 'string'
  twitter: FP.attr 'string'
  email: FP.attr 'string'
  createdAt: FP.attr 'date'
  isAdmin: FP.attr 'boolean'
  isWaiting: FP.attr 'boolean'
  waiting_time: FP.attr 'date'
  wins: FP.attr 'number'
  losses: FP.attr 'number'
  challenges: FP.hasMany('challenge', {embedded: false})
  responses: FP.hasMany('challenge', {embedded: false})
  avatar: FP.attr 'string'
  percentage: (->
    wins = @get('wins')
    losses = @get('losses')
    # totalGames = wins + @get('losses')
    # if totalGames > 0
    #   if wins > 0
    #     if wins == totalGames
    #       percentage = wins
    #     else
    #       percentage = wins / totalGames
    #   else
    #     percentage = -1 * losses
    # if totalGames == 0
    #   percentage = -99
    if losses < 1
      percentage = (wins * (wins + 1)) + 1
    else
      percentage = (wins / losses) * ( @get('totalGames') )
    Math.round(percentage * 100) / 100
  ).property('wins', 'losses', 'totalGames')
  totalGames: (->
    @get('wins') + @get('losses')
  ).property('wins', 'losses')
