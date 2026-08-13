ALTER TABLE feed_items
    DROP COLUMN search_terms;

ALTER TABLE feed_items
    ADD COLUMN search_terms tsvector
        GENERATED ALWAYS AS (
            TO_TSVECTOR(
                    'english',
                    COALESCE(title, '') || ' ' ||
                    COALESCE(description, '') || ' ' ||
                    COALESCE(content, '')
            )
            ) STORED;

CREATE INDEX idx_item_search ON feed_items USING GIN ("search_terms");
