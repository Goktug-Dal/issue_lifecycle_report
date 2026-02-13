TR:
    1-  Bootstrap bağlılığından kaçınmak için Redmine'ın 'list-issues' gibi CSS sınıflarını kullandım.

    2- ={} Hash yerine Hash.new() kullanmamın sebebi nil(NULL) hatasını toplama sırasında almamktır.


ENG:
    1- I have used Redmine's CSS classes like: 'list-issues' to avoid using bootstrap for dependency.

    2- I have used Hash.new(0) instead of ={} to not get Nil(NULL) addition errors.