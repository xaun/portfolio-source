$(document).ready ->
  (->
    Carousel =
      init: ->
        @image = 'img' # Used to select img tags
        @transitionTime = 500 # Timer for the jQuery animations
        # Fade's in the first image of each carousel.
        $( @image + "[class~='active']" ).fadeIn(@transitionTime)
        # Selects all the carousels images and assigns to variable.
        @$nextButton = $('.carousel').children('img')
        # Starts the event listener function.
        @eventRouter()

      eventRouter: ->
        # Keeps the scope of 'this' on Carousel object.
        @$nextButton.on "click", $.proxy(@event, this)

      event: (event) ->
        event.preventDefault()
        # Saves data attr object of targeted next button.
        @dataObject = $(event.target).data()
        # Saves the data attr value.
        @$carousel = @dataObject['carousel']

        # Gets the index of the currently active image, removes the 'active'
        # class & fades out.
        $i = $(@$carousel).find(@image + '.active').index()
        @images().eq($i).removeClass('active')
        @images().eq($i).fadeOut(@transitionTime)

        # Loop back to the start by reseting the index.
        $i = -1 if @images().length == $i + 1

        # Target the next image, fadeIn and set active.
        @images().eq($i + 1).fadeIn(@transitionTime)
        @images().eq($i + 1).addClass('active')

      images: ->
        $(@$carousel).find(@image)

    Carousel.init()
  )()

  # Show projects button.
  $('#threedee-description').hide()
  $('#cloudchaser-description').hide()

  $('.btn-5').on('click', (event) ->
    event.preventDefault()
    dataObject = $(event.target).data()
    $nextElementID = dataObject['nextElementId']
    $($nextElementID).show()
    $(this).hide()
    $(event.target).parent().css('padding-bottom', '40px')

    $('body').animate({ scrollTop: $($nextElementID).offset().top - 90 }, 1000)
  )


  ## Variables setup ##
  $windowHeight = $(window).height()
  $windowWidth = $(window).width()
  # All the images that are children of a carousel.
  $carouselImages = $('.carousel').children('img')
  # Spans across 100% page width beneath the carousels.
  $carouselContainer = $('.carousel-container')
  # All carousels.
  $carousels = $('.carousel')

  # Disabling mousedown event on carousel images.
  $carouselImages.mousedown( -> return false )

  $('#about').css 'height', ($windowHeight)

  $('#projects-link').off('click').on('click', ->
    $("body").finish().animate({ scrollTop: $('#projects').offset().top - 90 }, 1000);
  )

  $('#contact-link').off('click').on('click', ->
    $("body").finish().animate({ scrollTop: $('footer').offset().top }, 1000);
  )

  $('#phone-icon').on('click', (event) ->
    event.preventDefault()
    alert 'Feel free to contact me on 0410 345 171!'
  )

  # Carousel width controls on document ready.
  if $windowWidth < 770
    $carouselImages.css('width', ($windowWidth - 10))
    $carouselContainer.css('width', $carouselImages.width())
    $carousels.css('width', $carouselImages.width())
  else if $windowWidth > 700
    $carouselImages.css('width', '750px')

  # Carousel height controls on document ready.
  if $windowWidth < 770
    $carouselContainer.css('height', ($carouselImages.height() - 3))
    $carousels.css('height', ($carouselImages.height() - 3))
  else if $windowWidth > 770
    $carouselContainer.css('height', '400px')
    $carousels.css('height', '400px')

  $(window).on('resize', ->
    $windowWidth = $(window).width()

    if $windowWidth < 770
      $carouselImages.css('width', ($(window).width() - 10))
      $carouselContainer.css('height', ($carouselImages.height() - 3))
      $carouselContainer.css('width', $carouselImages.width())
      $carousels.css('height', ($carouselImages.height() - 3))
      $carousels.css('width', $carouselImages.width())

    else if $windowWidth > 770
      $carouselContainer.css('width', '750px')
      $carouselContainer.css('height', '400px')
      $carouselContainer.css('margin', 'auto')
      $carousels.css('width', '750px')
      $carousels.css('height', '400px')
      $carouselImages.css('width', '750px')
  )








