$(document).ready ->
  (->
    Carousel =
      init: ->
        @image = 'img' # Used to select img tags
        @transitionTime = 800 # Timer for the jQuery animations
        # Fade's in the first image of each carousel.
        $( @image + "[class~='active']" ).fadeIn(@transitionTime)
        # Selects all the carousels next buttons.
        @$nextButton = $('.carousel-arrow')
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


  windowHeight = $(window).height()
  $('#about').css 'height', (windowHeight)

  $('#projects-link').off('click').on('click', ->
    $("body").finish().animate({ scrollTop: $('#projects').offset().top - 90 }, 1000);
  )

  $('#contact-link').off('click').on('click', ->
    $("body").finish().animate({ scrollTop: $('footer').offset().top }, 1000);
  )










