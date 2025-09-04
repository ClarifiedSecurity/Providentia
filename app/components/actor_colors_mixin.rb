# frozen_string_literal: true

module ActorColorsMixin
  extend ActiveSupport::Concern

  included do
    include ViewComponentContrib::StyleVariants

    style :actor do
      defaults { { color: :gray, mode: :default } }

      compound(color: :slate, mode: :text) {
        %w(text-slate-800 dark:text-slate-300)
      }
      compound(color: :amber, mode: :text) {
        %w(text-amber-800 dark:text-amber-300)
      }
      compound(color: :emerald, mode: :text) {
        %w(text-emerald-800 dark:text-emerald-300)
      }
      compound(color: :rose, mode: :text) {
        %w(text-rose-800 dark:text-rose-300)
      }
      compound(color: :sky, mode: :text) {
        %w(text-sky-800 dark:text-sky-300)
      }
      compound(color: :orange, mode: :text) {
        %w(text-orange-800 dark:text-orange-300)
      }
      compound(color: :yellow, mode: :text) {
        %w(text-yellow-800 dark:text-yellow-300)
      }
      compound(color: :violet, mode: :text) {
        %w(text-violet-800 dark:text-violet-300)
      }


      compound(color: :slate, mode: :default) {
        %w(transition-colors bg-slate-200 text-slate-800 hover:bg-slate-300 dark:bg-slate-700 dark:text-slate-300 dark:hover:bg-slate-800)
      }
      compound(color: :amber, mode: :default) {
        %w(transition-colors bg-amber-200 text-amber-800 hover:bg-amber-300 dark:bg-amber-700 dark:text-amber-300 dark:hover:bg-amber-800)
      }
      compound(color: :emerald, mode: :default) {
        %w(transition-colors bg-emerald-200 text-emerald-800 hover:bg-emerald-300 dark:bg-emerald-700 dark:text-emerald-300 dark:hover:bg-emerald-800)
      }
      compound(color: :rose, mode: :default) {
        %w(transition-colors bg-rose-200 text-rose-800 hover:bg-rose-300 dark:bg-rose-700 dark:text-rose-300 dark:hover:bg-rose-800)
      }
      compound(color: :sky, mode: :default) {
        %w(transition-colors bg-sky-200 text-sky-800 hover:bg-sky-300 dark:bg-sky-700 dark:text-sky-300 dark:hover:bg-sky-800)
      }
      compound(color: :orange, mode: :default) {
        %w(transition-colors bg-orange-200 text-orange-800 hover:bg-orange-300 dark:bg-orange-700 dark:text-orange-300 dark:hover:bg-orange-800)
      }
      compound(color: :yellow, mode: :default) {
        %w(transition-colors bg-yellow-200 text-yellow-800 hover:bg-yellow-300 dark:bg-yellow-700 dark:text-yellow-300 dark:hover:bg-yellow-800)
      }
      compound(color: :violet, mode: :default) {
        %w(transition-colors bg-violet-200 text-violet-800 hover:bg-violet-300 dark:bg-violet-700 dark:text-violet-300 dark:hover:bg-violet-800)
      }

      compound(color: :slate, mode: :subtle) {
        %w(transition-colors bg-slate-50 text-slate-800 hover:bg-slate-100 dark:bg-slate-900 dark:text-slate-300 dark:hover:bg-slate-800)
      }
      compound(color: :amber, mode: :subtle) {
        %w(transition-colors bg-amber-50 text-amber-800 hover:bg-amber-100 dark:bg-amber-900 dark:text-amber-300 dark:hover:bg-amber-800)
      }
      compound(color: :emerald, mode: :subtle) {
        %w(transition-colors bg-emerald-50 text-emerald-800 hover:bg-emerald-100 dark:bg-emerald-900 dark:text-emerald-300 dark:hover:bg-emerald-800)
      }
      compound(color: :rose, mode: :subtle) {
        %w(transition-colors bg-rose-50 text-rose-800 hover:bg-rose-100 dark:bg-rose-900 dark:text-rose-300 dark:hover:bg-rose-800)
      }
      compound(color: :sky, mode: :subtle) {
        %w(transition-colors bg-sky-50 text-sky-800 hover:bg-sky-100 dark:bg-sky-900 dark:text-sky-300 dark:hover:bg-sky-800)
      }
      compound(color: :orange, mode: :subtle) {
        %w(transition-colors bg-orange-50 text-orange-800 hover:bg-orange-100 dark:bg-orange-900 dark:text-orange-300 dark:hover:bg-orange-800)
      }
      compound(color: :yellow, mode: :subtle) {
        %w(transition-colors bg-yellow-50 text-yellow-800 hover:bg-yellow-100 dark:bg-yellow-900 dark:text-yellow-300 dark:hover:bg-yellow-800)
      }
      compound(color: :violet, mode: :subtle) {
        %w(transition-colors bg-violet-50 text-violet-800 hover:bg-violet-100 dark:bg-violet-900 dark:text-violet-300 dark:hover:bg-violet-800)
      }

      compound(color: :slate, mode: :radio) {
        %w(peer-checked:outline-slate-500 bg-slate-500 dark:bg-slate-700)
      }
      compound(color: :amber, mode: :radio) {
        %w(peer-checked:outline-amber-500 bg-amber-500 dark:bg-amber-700)
      }
      compound(color: :emerald, mode: :radio) {
        %w(peer-checked:outline-emerald-500 bg-emerald-500 dark:bg-emerald-700)
      }
      compound(color: :rose, mode: :radio) {
        %w(peer-checked:outline-rose-500 bg-rose-500 dark:bg-rose-700)
      }
      compound(color: :sky, mode: :radio) {
        %w(peer-checked:outline-sky-500 bg-sky-500 dark:bg-sky-700)
      }
      compound(color: :orange, mode: :radio) {
        %w(peer-checked:outline-orange-500 bg-orange-500 dark:bg-orange-700)
      }
      compound(color: :yellow, mode: :radio) {
        %w(peer-checked:outline-yellow-500 bg-yellow-500 dark:bg-yellow-700)
      }
      compound(color: :violet, mode: :radio) {
        %w(peer-checked:outline-violet-500 bg-violet-500 dark:bg-violet-700)
      }
    end
  end
end
