require 'test_helper'
require_relative '../support/normalizer_test_helper'

class TelegaNormalizerTest < Minitest::Test
  include NormalizerTestHelper

  def subject
    TelegaNormalizer
  end

  def processor
    RssProcessor
  end

  def sample_data_file
    'feed_agavr_today.xml'.freeze
  end

  def test_have_sample_data
    assert(processed.present?)
    assert(processed.any?)
  end

  def test_normalization
    assert(normalized.any?)
    assert(normalized.all?(&:success?))
  end

  # rubocop:disable Metrics/LineLength
  FIRST_SAMPLE = {
    uid: 'http://tele.ga/agavr_today/126.html',
    link: 'http://tele.ga/agavr_today/126.html',
    published_at: DateTime.parse('2017-09-07 14:51:45 +0000'),
    text: 'Находясь в настоящий момент в двух поразительных тяжбах в Израиле, я всё думаю: ведь не напрасно Кафка был еврей. Но умереть планирую позже, чем завершу. Это и есть еврейский оптимизм - http://tele.ga/agavr_today/126.html',
    attachments: [],
    comments: ["Forwarded from Белый шум (https://t.me/Polyarinov/95):\n\nЕще о сиквелах, ремейках и ребутах. Я вот что вспомнил: «Превращение» Кафки заканчивается совершенно гениально — там же настоящий задел на сиквел. После смерти Грегора вся семья идет гулять:\n\n«Затем они покинули квартиру все вместе, чего уже много месяцев не делали, и поехали на трамвае за город Господину и госпоже Замза при виде их все более оживлявшейся дочери почти одновременно подумалось, что, несмотря на все горести, покрывшие бледностью ее щеки, она за последнее время расцвела и стала пышной красавицей. Приумолкнув и почти безотчетно перейдя на язык взглядов, они думали о том, что вот и пришло время подыскать ей хорошего мужа. И как бы в утверждение их новых мечтаний и прекрасных намерений, дочь первая поднялась в конце их поездки и выпрямила свое молодое тело».\n\nТак вот, я все придумал: сиквел назовем «Синекдоха, Превращение».\n\nСюжет такой: Грета Замза встречает мужчину своей мечты, они влюблены, у них роман, мужчина делает ей предложение, и они идут в ЗАГС. Но в ЗАГСе чиновник говорит им, что в этом году лимит свадеб исчерпан, но вы, конечно, можете записаться на следующий год. Встать в очередь. И Грета Замза и ее возлюбленный записываются в очередь на свадьбу. Проходит год, Грета уже беременна, она каждый день зачеркивает даты в календаре — считает дни до свадьбы. Затем они с возлюбленным снова идут в ЗАГС, но там им сообщают, что их место в очереди потерялось. Возлюбленный Греты спрашивает, что... (continued)"],
    validation_errors: []
  }.freeze

  SECOND_SAMPLE = {
    uid: 'http://tele.ga/agavr_today/120.html',
    link: 'http://tele.ga/agavr_today/120.html',
    published_at: DateTime.parse('2017-08-30 11:27:28 +0000'),
    text: 'Католический святой Боэций прожил жизнь, вполне понятную любому, кто интересовался русской историей ХХ века: прилежно занимался наукой, по идиотическому и очевидно ложному обвинению сидел в тюрьме, рассказывал товарищам по заключению всякие философические байки, из которых потом сделал, не выходя из тюрьмы, книгу "Утешение философией", казнён. - http://tele.ga/agavr_today/120.html',
    attachments: [],
    comments: ["Книга, представляющая собой диалог несчастного и подавленного Боэция с самой Философией (а она ему отвечает: то ли ещё бывало! ты же читал!), была настолько популярна в средневековьи, что ее фрагменты неоднократно становились песнями и в таком виде раходились по Европе. Не знаю, с чем сравнить - ну, как если бы нищие по электричкам пели из \"Архипелага Гулаг\" или хотя бы из \"Розы мира\" Даниила Андреева. Доктор Сэм Баррет из Кембриджского университета постарался восстановить звучание этих песен и университетский ансамбль исполнил их в этой новой, но вполне аутентичной аранжировке.\n\nRead more » (http://tele.ga/agavr_today/120.html)"],
    validation_errors: []
  }.freeze
  # rubocop:enable Metrics/LineLength

  def test_normalized_sample
    assert_equal(FIRST_SAMPLE, normalized.first.value!)
    assert_equal(SECOND_SAMPLE, normalized.second.value!)
  end
end
