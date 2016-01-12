package stefansavev.esplugins;

import org.apache.lucene.search.similarities.Similarity;
import org.elasticsearch.common.inject.Inject;
import org.elasticsearch.common.inject.assistedinject.Assisted;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.index.similarity.*;

public class OverlapSimilarityProvider extends AbstractSimilarityProvider {

    private OverlapSimilarity similarity;

    @Inject
    public OverlapSimilarityProvider(@Assisted String name, @Assisted Settings settings) {
        super(name);
        this.similarity = new OverlapSimilarity();
    }

    @Override
    public Similarity get() {
        return similarity;
    }

}
