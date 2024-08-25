class CreateMissingTranslationsService
  def call
    Translation.connection.execute(insert_statement_sql)
  end

  private

  def insert_statement_sql
    <<~SQL.squish
      INSERT INTO translations (
          word_id
        , target_word_id
        , created_at
        , updated_at
      )
      SELECT t.target_word_id                  AS word_id
           , t.word_id                         AS target_word_id
           , datetime('now', 'subsecond')      AS created_at
           , datetime('now', 'subsecond')      AS updated_at
        FROM translations t
        LEFT OUTER JOIN translations t1 ON t1.word_id = t.target_word_id
                                       AND t1.target_word_id = t.word_id
       WHERE t1.word_id IS NULL
    SQL
  end
end
