module FavoritesHelper

  def move_favorite_up(favorites, favorite)
    if favorite[:rank] != 1
      better_rank = favorite[:rank] - 1
      worse_rank = favorite[:rank]
      other_favorite = favorites.find_by(rank: better_rank)
      favorite[:rank] = better_rank
      other_favorite[:rank] = worse_rank
      favorite.save
      other_favorite.save
    end
  end

  def move_favorite_down(favorites, favorite)
    if favorite[:rank] != favorites.length
      worse_rank = favorite[:rank] + 1
      better_rank = favorite[:rank]
      other_favorite = favorites.find_by(rank: worse_rank)
      favorite[:rank] = worse_rank
      other_favorite[:rank] = better_rank
      favorite.save
      other_favorite.save
    end
  end

  # make sure that favorite ranking is consecutive starting at 1
  def normalize_rank(favorites)
    new_rank = 1
    favorites.order(:rank).each do |favorite|
      favorite[:rank] = new_rank
      favorite.save
      new_rank += 1
    end
  end



end

