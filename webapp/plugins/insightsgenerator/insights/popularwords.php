<?php
/*
 Plugin Name: Popular Words
 Description: Your most popular words posted this week.
 When: Fridays
 */

/**
 *
 * ThinkUp/webapp/plugins/insightsgenerator/insights/popularwords.php
 *
 * Copyright (c) 2014 Anil Dash, Nilaksh Das, Gina Trapani
 *
 * LICENSE:
 *
 * This file is part of ThinkUp (http://thinkup.com).
 *
 * ThinkUp is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any
 * later version.
 *
 * ThinkUp is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with ThinkUp.  If not, see
 * <http://www.gnu.org/licenses/>.
 *
 * @license http://www.gnu.org/licenses/gpl.html
 * @copyright 2014 Anil Dash, Nilaksh Das, Gina Trapani
 * @author Anil Dash <anil [at] dashes [dot] com>
 */

class PopularWordsInsight extends InsightPluginParent implements InsightPlugin {
    public function generateInsight(Instance $instance, User $user, $last_week_of_posts, $number_days) {
        parent::generateInsight($instance, $user, $last_week_of_posts, $number_days);
        $this->logger->logInfo("Begin generating insight", __METHOD__.','.__LINE__);

        $should_generate_insight = self::shouldGenerateWeeklyInsight('popularwords', $instance, $insight_date='today',
            $regenerate_existing_insight=true, $day_of_week=3, count($last_week_of_posts),
            $excluded_networks=array('google+', 'foursquare', 'youtube'));
        if ($should_generate_insight) {

            $popularwords = '';
            $posts_text = '';

            foreach ($last_week_of_posts as $post) {
                if (!isset($post->in_retweet_of_post_id)) {
                    $posts_text .= $post->post_text;
                }
            }

            $text = strtolower($text);
            // Fetch all words
            $extract_words = str_word_count($text);

            preg_match_all('~[\w-]+~', $text, $words);

            // Count word occurrences.
            $words = array_count_values($words[0]);
            // Sort in descendant order
            arsort($words);

            $words = array_slice($words, 0, 49);

            $wordlist = implode(" \n", array_keys($words));

            $insight_text = $wordlist;


            $this->logger->logInfo($insight_text, "WORD LIST: ");

            $my_insight = null;
            $headline = "These were your most used words this week.";
            $my_insight->insight_text = $insight_text;
            $my_insight = new Insight();
            $my_insight->slug = 'popular_words'; //slug to label this insight's content
            $my_insight->instance_id = $instance->id;
            $my_insight->date = $this->insight_date; //date is often this or $simplified_post_date
            $my_insight->headline = $headline; // or just set a string like 'Ohai';
            $my_insight->text = $insight_text; // or just set a strong like "Greetings humans";
            $my_insight->filename = basename(__FILE__, ".php"); //Same for every insight, must be set this way
            $my_insight->emphasis = Insight::EMPHASIS_HIGH; //Optional emphasis, default is Insight::EMPHASIS_LOW
            // $my_insight->setHeroImage($hero_image);

            $this->insight_dao->insertInsight($my_insight);


        }

        $this->logger->logInfo("Done generating insight", __METHOD__.','.__LINE__);
    }
}

$insights_plugin_registrar = PluginRegistrarInsights::getInstance();
$insights_plugin_registrar->registerInsightPlugin('PopularWordsInsight');
