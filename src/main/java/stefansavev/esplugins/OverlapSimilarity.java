package stefansavev.esplugins;

import org.apache.lucene.index.FieldInvertState;
import org.apache.lucene.index.LeafReaderContext;
import org.apache.lucene.index.NumericDocValues;
import org.apache.lucene.search.CollectionStatistics;
import org.apache.lucene.search.Explanation;
import org.apache.lucene.search.TermStatistics;
import org.apache.lucene.search.similarities.DefaultSimilarity;
import org.apache.lucene.search.similarities.Similarity;
import org.apache.lucene.util.BytesRef;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@SuppressWarnings("serial")
public class OverlapSimilarity extends Similarity {

    public float queryNorm(float valueForNormalization) {
        return 1.0F;
    }

    //called at indexing time to compute the norm of a document
    public final long computeNorm(FieldInvertState state) {
        final int numTerms = state.getLength();
        return (long)numTerms;
    }

    private static class OverlapStats extends Similarity.SimWeight {
        private final String field;
        private float queryWeight;

        public OverlapStats(String field, float queryWeight) {
            this.field = field;
            this.queryWeight = queryWeight;
        }

        @Override
        public float getValueForNormalization() {
            return 1.0f;
        }

        @Override
        public void normalize(float queryNorm, float topLevelBoost) {
            float w = 1.0f/queryNorm;
            queryWeight = w*w;
        }
    }

    @Override
    public final SimWeight computeWeight(float queryBoost, CollectionStatistics collectionStats, TermStatistics... termStats) {
        float numTerms = (float)termStats.length;
        return new OverlapStats(collectionStats.field(), numTerms);
    }

    @Override
    public final SimScorer simScorer(SimWeight stats, LeafReaderContext context) throws IOException {
        OverlapStats overlapStats = (OverlapStats) stats;
        return new OverlapScorer(overlapStats, context.reader().getNormValues(overlapStats.field));
    }

    private final class OverlapScorer extends SimScorer {
        private final OverlapStats stats;
        private final NumericDocValues norms;

        OverlapScorer(OverlapStats stats, NumericDocValues norms) throws IOException {
            this.stats = stats;
            this.norms = norms;
        }

        @Override
        public float score(int doc, float freq) {
            final float raw = 1.0f; //ignore freq
            long docWeight = norms.get(doc);
            float queryWeight = stats.queryWeight;
            float norm = Math.max((float)docWeight, queryWeight);
            return norms == null ? raw : raw / norm;
        }

        //we don't use pharses
        @Override
        public float computeSlopFactor(int distance) {
            return 1.0f;
        }

        //we don't use payload
        @Override
        public float computePayloadFactor(int doc, int start, int end, BytesRef payload) {
            return 1.0f;
        }

        @Override
        public Explanation explain(int doc, Explanation freq) {
            Explanation fieldNormExpl = Explanation.match(
                    norms != null ? (norms.get(doc)) : 1.0f,
                    "fieldNorm(doc=" + doc + ")");
            float queryWeight = stats.queryWeight;
            Explanation docWeightExpl = Explanation.match(queryWeight, "queryWeight");
            return Explanation.match(1.0f, "singlematch", fieldNormExpl, docWeightExpl);
        }
    }

}
