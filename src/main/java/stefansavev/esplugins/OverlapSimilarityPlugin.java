package stefansavev.esplugins;

import org.elasticsearch.index.similarity.SimilarityModule;
import org.elasticsearch.plugins.Plugin;

public class OverlapSimilarityPlugin extends Plugin {

    @Override
    public String name() {
        return "overlap-similarity-plugin";
    }

    @Override
    public String description() {
        return "Overlap Similarity Plugin";
    }

    public void onModule(final SimilarityModule module) {
        module.addSimilarity("overlapsimilarity", OverlapSimilarityProvider.class);
    }
}
